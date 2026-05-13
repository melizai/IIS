package org.datasource.jpa.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.datasource.jpa.views.PaymentView;
import org.datasource.jpa.repository.PaymentRepository;

import java.util.List;

@RestController
@RequestMapping("/rest/sales")
public class PaymentController {

    private final PaymentRepository paymentRepository;

    public PaymentController(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }

    @GetMapping("/PaymentView")
    public List<PaymentView> getPayments() {
        return paymentRepository.findAll().stream()
                .map(p -> new PaymentView(
                        p.getPaymentId(),
                        p.getOrder().getOrderId(),
                        p.getPaymentTs(),
                        p.getMethod(),
                        p.getAmount()
                ))
                .toList();
    }
}