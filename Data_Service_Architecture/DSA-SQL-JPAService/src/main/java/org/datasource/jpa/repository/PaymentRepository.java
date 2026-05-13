package org.datasource.jpa.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.datasource.jpa.entity.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
}