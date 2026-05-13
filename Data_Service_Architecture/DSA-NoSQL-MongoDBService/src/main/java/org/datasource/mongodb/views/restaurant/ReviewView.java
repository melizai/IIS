package org.datasource.mongodb.views.restaurant;

import lombok.Data;

@Data
public class ReviewView {
    private Integer orderId;
    private Integer menuItemId;
    private Integer rating;
    private String comment;
}