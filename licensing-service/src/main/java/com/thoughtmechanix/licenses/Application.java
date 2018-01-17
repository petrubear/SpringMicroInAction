package com.thoughtmechanix.licenses;

import com.thoughtmechanix.licenses.config.ServiceConfig;
import com.thoughtmechanix.licenses.events.models.OrganizationChangeModel;
import com.thoughtmechanix.licenses.utils.UserContextInterceptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.stream.annotation.EnableBinding;
import org.springframework.cloud.stream.annotation.StreamListener;
import org.springframework.cloud.stream.messaging.Sink;
import org.springframework.context.annotation.Bean;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.List;

//@SpringBootApplication
//@RefreshScope
//@EnableEurekaClient
//@EnableHystrix  //si esto no se agrega no funcionan los circuit breakers y no muestra error
//@EnableResourceServer
@SpringBootApplication
@EnableEurekaClient
@EnableCircuitBreaker
@EnableResourceServer
@EnableBinding(Sink.class)
public class Application {

    @Autowired
    private ServiceConfig serviceConfig;

    private static final Logger logger = LoggerFactory.getLogger(Application.class);

    @StreamListener(Sink.INPUT)
    public void loggerSink(OrganizationChangeModel orgChange) {
        logger.debug("Received an event for organization id {}", orgChange.getOrganizationId());
    }


    //    @Bean
//    public OAuth2RestTemplate oauth2RestTemplate(OAuth2ClientContext oauth2ClientContext,
//                                                 OAuth2ProtectedResourceDetails details) {
//        return new OAuth2RestTemplate(details, oauth2ClientContext);
//    }
    @LoadBalanced
    @Bean
    public RestTemplate getRestTemplate() {
        RestTemplate template = new RestTemplate();
        List interceptors = template.getInterceptors();
        if (interceptors == null) {
            template.setInterceptors(Collections.singletonList(new UserContextInterceptor()));
        } else {
            interceptors.add(new UserContextInterceptor());
            template.setInterceptors(interceptors);
        }

        return template;
    }

    public static void main(String... args) {
        SpringApplication.run(Application.class, args);
    }
}
