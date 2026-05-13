package org.datasource.jpa.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "PAYMENTS", schema = "SALES")
@Getter
@Setter
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PAYMENT_ID")
    private Long paymentId;

    @ManyToOne
    @JoinColumn(name = "ORDER_ID", nullable = false)
    private Order order;

    @Column(name = "PAYMENT_TS", nullable = false)
    private LocalDateTime paymentTs;

    @Column(name = "METHOD", nullable = false)
    private String method;

    @Column(name = "AMOUNT", nullable = false)
    private BigDecimal amount;
}