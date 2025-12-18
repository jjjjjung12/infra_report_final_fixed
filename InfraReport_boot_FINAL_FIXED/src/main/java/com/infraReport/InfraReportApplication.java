package com.infraReport;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 일일업무보고서 통합관리 시스템 + 작업관리
 * Main Application
 */
@SpringBootApplication
@MapperScan("com.infraReport.**.dao")
public class InfraReportApplication {

    public static void main(String[] args) {
        SpringApplication.run(InfraReportApplication.class, args);
    }
}
