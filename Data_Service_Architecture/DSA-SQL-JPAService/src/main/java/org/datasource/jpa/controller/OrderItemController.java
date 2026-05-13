package org.datasource.jpa.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.datasource.jpa.views.OrderItemView;
import org.datasource.jpa.repository.OrderItemRepository;

import java.util.List;

@RestController
@RequestMapping("/rest/sales")
public class OrderItemController {

    private final OrderItemRepository orderItemRepository;

    public OrderItemController(OrderItemRepository orderItemRepository) {
        this.orderItemRepository = orderItemRepository;
    }

    @GetMapping("/OrderItemView")
    public List<OrderItemView> getOrderItems() {
        return orderItemRepository.findAll().stream()
                .map(oi -> new OrderItemView(
                        oi.getOrderItemId(),
                        oi.getOrder().getOrderId(),
                        oi.getMenuItemId(),
                        oi.getQuantity(),
                        oi.getUnitPrice(),
                        oi.getLineTotal()
                ))
                .toList();
    }
}