package org.datasource.jpa.views;


import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class PaymentView {
    private Long paymentId;
    private Long orderId;
    private LocalDateTime paymentTs;
    private String method;
    private BigDecimal amount;
}