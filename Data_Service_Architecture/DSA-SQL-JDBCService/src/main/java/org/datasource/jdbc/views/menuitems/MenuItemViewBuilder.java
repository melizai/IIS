package org.datasource.jdbc.views.menuitems;

import org.datasource.jdbc.JDBCDataSourceConnector;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Service
public class MenuItemViewBuilder {
    private static Logger logger = Logger.getLogger(MenuItemViewBuilder.class.getName());

    private final String SQL_MENU_ITEMS_SELECT = """
            SELECT menu_item_id, name, category, price, is_active
            FROM customers.menu_items
            ORDER BY menu_item_id
            """;

    private Integer fetchOffset = -1;
    private Integer fetchSize = 25;

    private List<MenuItemView> viewList = new ArrayList<>();

    private JDBCDataSourceConnector jdbcConnector;

    public MenuItemViewBuilder(JDBCDataSourceConnector jdbcConnector) {
        this.jdbcConnector = jdbcConnector;
    }

    public List<MenuItemView> getViewList() {
        return viewList;
    }

    public MenuItemViewBuilder build() {
        logger.info(">>> Building MenuItemView");
        try (Connection jdbcConnection = jdbcConnector.getConnection()) {
            String sql = SQL_MENU_ITEMS_SELECT;
            PreparedStatement stmt;

            if (fetchOffset != null && fetchOffset > 0) {
                sql = String.format(SQL_FETCH_SELECT, SQL_MENU_ITEMS_SELECT);
                stmt = jdbcConnection.prepareStatement(sql);
                stmt.setInt(1, fetchOffset);
                stmt.setInt(2, fetchOffset + fetchSize);
            } else {
                stmt = jdbcConnection.prepareStatement(sql);
            }

            ResultSet rs = stmt.executeQuery();

            viewList = new ArrayList<>();
            while (rs.next()) {
                Long menuItemId = rs.getLong("menu_item_id");
                String name = rs.getString("name");
                String category = rs.getString("category");
                Double price = rs.getDouble("price");
                Boolean isActive = rs.getBoolean("is_active");

                viewList.add(new MenuItemView(menuItemId, name, category, price, isActive));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return this;
    }

    public MenuItemViewBuilder setFetchOffset(Integer fetchOffset) {
        if (fetchOffset != null) {
            this.fetchOffset = fetchOffset;
        }
        return this;
    }

    public MenuItemViewBuilder setFetchSize(Integer fetchSize) {
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