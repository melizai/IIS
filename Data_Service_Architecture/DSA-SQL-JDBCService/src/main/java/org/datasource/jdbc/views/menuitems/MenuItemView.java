package org.datasource.jdbc.views.menuitems;

import lombok.Value;

@Value
public class MenuItemView {
    private Long menuItemId;
    private String name;
    private String category;
    private Double price;
    private Boolean isActive;
}