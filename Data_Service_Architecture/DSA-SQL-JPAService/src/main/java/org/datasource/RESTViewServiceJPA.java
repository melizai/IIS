package org.datasource;

import org.datasource.jpa.views.OrderItemView;
import org.datasource.jpa.views.OrderView;
import org.datasource.jpa.views.PaymentView;
import org.datasource.jpa.entity.Order;
import org.datasource.jpa.entity.OrderItem;
import org.datasource.jpa.entity.Payment;
import org.datasource.jpa.repository.OrderItemRepository;
import org.datasource.jpa.repository.OrderRepository;
import org.datasource.jpa.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.logging.Logger;

/*
    REST Service URL
    http://localhost:8091/DSA_SQL_JPAService/rest/sales/OrderView
    http://localhost:8091/DSA_SQL_JPAService/rest/sales/OrderItemView
    http://localhost:8091/DSA_SQL_JPAService/rest/sales/PaymentView
*/
@RestController
@RequestMapping("/sales")
public class RESTViewServiceJPA {

	private static Logger logger = Logger.getLogger(RESTViewServiceJPA.class.getName());

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private OrderItemRepository orderItemRepository;

	@Autowired
	private PaymentRepository paymentRepository;

	@RequestMapping(value = "/ping", method = RequestMethod.GET,
			produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public String pingDataSource() {
		logger.info(">>>> DSA-SQL-JPAService:: RESTViewService is Up!");
		return "Ping response from DSA-SQL-JPAService!";
	}

	@RequestMapping(value = "/OrderView", method = RequestMethod.GET,
			produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public List<OrderView> get_OrderView() {
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

	@RequestMapping(value = "/OrderItemView", method = RequestMethod.GET,
			produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public List<OrderItemView> get_OrderItemView() {
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

	@RequestMapping(value = "/PaymentView", method = RequestMethod.GET,
			produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public List<PaymentView> get_PaymentView() {
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