package org.datasource;

import org.datasource.mongodb.views.restaurant.ReviewView;
import org.datasource.mongodb.views.restaurant.ReviewViewBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.logging.Logger;

@RestController
@RequestMapping("/restaurant")
public class RESTViewServiceMongoDB {
	private static Logger logger = Logger.getLogger(RESTViewServiceMongoDB.class.getName());

	@RequestMapping(value = "/ping", method = RequestMethod.GET,
			produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public String pingDataSource() {
		logger.info(">>>> org.datasource.RESTViewServiceMongoDB(JSON) for Restaurant is Up!");
		return "Ping response from Restaurant MongoDB Service!";
	}

	@RequestMapping(value = "/ReviewView", method = RequestMethod.GET,
			produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public List<ReviewView> get_ReviewView() throws Exception {
		List<ReviewView> viewList = this.viewBuilder.build().getReviewViewList();
		return viewList;
	}

	@Autowired
	private ReviewViewBuilder viewBuilder;
}