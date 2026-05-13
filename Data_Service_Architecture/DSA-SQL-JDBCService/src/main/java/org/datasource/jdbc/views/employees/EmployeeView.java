package org.datasource.jdbc.views.employees;

import lombok.Value;

@Value
public class EmployeeView {
    private Long employeeId;
    private String fullName;
    private String role;
    private String hireDate;
    private Boolean isActive;
}