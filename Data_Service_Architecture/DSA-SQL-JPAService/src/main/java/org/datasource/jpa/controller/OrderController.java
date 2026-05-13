package org.datasource.jpa.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.datasource.jpa.views.OrderView;
import org.datasource.jpa.entity.Order;
import org.datasource.jpa.repository.OrderRepository;

import java.util.List;

@RestController
@RequestMapping("/rest/sales")
public class OrderController {

    private final OrderRepository orderRepository;

    public OrderController(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @GetMapping("/OrderView")
    public List<OrderView> getOrders() {
        return orderRepository.findAll().stream()
                .map(o -> new OrderView(
                        o.getOrderId(),
                        o.getOrderTs(),
                        o.getChannel(),
                        o.getCashierId(),
                        o.getTotalAmount()
                ))
                .toList();
    }
}