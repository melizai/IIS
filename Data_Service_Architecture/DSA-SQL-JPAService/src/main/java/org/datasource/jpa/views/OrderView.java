package org.datasource.jpa.views;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class OrderView {
    private Long orderId;
    private LocalDateTime orderTs;
    private String channel;
    private Long cashierId;
    private BigDecimal totalAmount;
}