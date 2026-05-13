package org.datasource.jdbc.views.employees;

import org.datasource.jdbc.JDBCDataSourceConnector;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Service
public class EmployeeViewBuilder {
    private static Logger logger = Logger.getLogger(EmployeeViewBuilder.class.getName());

    private final String SQL_EMPLOYEES_SELECT = """
            SELECT employee_id, full_name, role, hire_date, is_active
            FROM customers.employees
            ORDER BY employee_id
            """;

    private Integer fetchOffset = -1;
    private Integer fetchSize = 25;

    private List<EmployeeView> viewList = new ArrayList<>();

    private JDBCDataSourceConnector jdbcConnector;

    public EmployeeViewBuilder(JDBCDataSourceConnector jdbcConnector) {
        this.jdbcConnector = jdbcConnector;
    }

    public List<EmployeeView> getViewList() {
        return viewList;
    }

    public EmployeeViewBuilder build() {
        logger.info(">>> Building EmployeeView");
        try (Connection jdbcConnection = jdbcConnector.getConnection()) {
            String sql = SQL_EMPLOYEES_SELECT;
            PreparedStatement stmt;

            if (fetchOffset != null && fetchOffset > 0) {
                sql = String.format(SQL_FETCH_SELECT, SQL_EMPLOYEES_SELECT);
                stmt = jdbcConnection.prepareStatement(sql);
                stmt.setInt(1, fetchOffset);
                stmt.setInt(2, fetchOffset + fetchSize);
            } else {
                stmt = jdbcConnection.prepareStatement(sql);
            }

            ResultSet rs = stmt.executeQuery();

            viewList = new ArrayList<>();
            while (rs.next()) {
                Long employeeId = rs.getLong("employee_id");
                String fullName = rs.getString("full_name");
                String role = rs.getString("role");
                String hireDate = rs.getDate("hire_date").toString();
                Boolean isActive = rs.getBoolean("is_active");

                viewList.add(new EmployeeView(employeeId, fullName, role, hireDate, isActive));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return this;
    }

    public EmployeeViewBuilder setFetchOffset(Integer fetchOffset) {
        if (fetchOffset != null) {
            this.fetchOffset = fetchOffset;
        }
        return this;
    }

    public EmployeeViewBuilder setFetchSize(Integer fetchSize) {
        if (fetchSize != null) {
            this.fetchSize = fetchSize;
        }
        return this;
    }

    private String SQL_FETCH_SELECT = """
            SELECT *
              FROM (
                   SELECT Q_.*,
                          ROW_NUMBER() OVER(ORDER BY 1) RN___
                     FROM (
                          %s
                   ) Q_
            ) Q__
             WHERE RN___ BETWEEN ? AND ?
            """;
}