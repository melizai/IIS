package org.datasource;

import org.datasource.jdbc.JDBCDataSourceConnector;
import org.datasource.jdbc.views.menuitems.MenuItemView;
import org.datasource.jdbc.views.menuitems.MenuItemViewBuilder;
import org.datasource.jdbc.views.employees.EmployeeView;
import org.datasource.jdbc.views.employees.EmployeeViewBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.logging.Logger;

@RestController
@RequestMapping("/restaurant")
public class RESTViewServiceJDBC {
	private static Logger logger = Logger.getLogger(RESTViewServiceJDBC.class.getName());

	@RequestMapping(value = "/ping", method = RequestMethod.GET,
			produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public String ping() {
		logger.info(">>>> DSA-SQL-JDBCService:: RESTViewService is Up!");
		return "Ping response from DSA-SQL-JDBCService!";
	}

	@RequestMapping(value = "/MenuItemView", method = RequestMethod.GET,
			produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public List<MenuItemView> get_MenuItemView() {
		return menuItemViewBuilder.build().getViewList();
	}

	@RequestMapping(value = "/EmployeeView", method = RequestMethod.GET,
			produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public List<EmployeeView> get_EmployeeView() {
		return employeeViewBuilder.build().getViewList();
	}

	@Autowired private JDBCDataSourceConnector jdbcConnector;
	@Autowired private MenuItemViewBuilder menuItemViewBuilder;
	@Autowired private EmployeeViewBuilder employeeViewBuilder;
}