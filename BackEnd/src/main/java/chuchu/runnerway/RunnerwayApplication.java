package chuchu.runnerway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class RunnerwayApplication {

	public static void main(String[] args) {
		SpringApplication.run(RunnerwayApplication.class, args);
	}

}
