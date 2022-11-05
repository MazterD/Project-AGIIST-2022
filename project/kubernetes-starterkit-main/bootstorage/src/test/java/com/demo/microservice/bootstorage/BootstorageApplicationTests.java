package com.demo.microservice.bootstorage;

import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class BootstorageApplicationTests { 

	@Test
	public void contextLoads() {
	}

	@Test
	public void simpleTest() {
		// Arrange
		int op1 = 2;
		int op2 = 4;
		int expectedResult = 6;
		// Act
		int result = op1 + op2;
		// Assert
		assertEquals(expectedResult, result);
	}

}

