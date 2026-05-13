package org.datasource.jpa.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.datasource.jpa.entity.OrderItem;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
}