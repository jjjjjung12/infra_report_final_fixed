package com.infraReport.config;

import java.io.IOException;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

@Configuration
@MapperScan(basePackages = "com.infraReport.**.dao")
public class MyBatisConfig {

    @Bean
    public SqlSessionFactory sqlSessionFactory(@Qualifier("dataSource") DataSource dataSource) throws IOException {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);

        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sqlSessionFactoryBean.setConfigLocation(resolver.getResource("classpath:/mybatis/mybatis-config.xml"));
        sqlSessionFactoryBean.setMapperLocations(resolver.getResources("classpath:/mappers/*.xml"));

        try {
            return sqlSessionFactoryBean.getObject();
        } catch (Exception e) {
            throw new RuntimeException("SqlSessionFactory 생성 실패", e);
        }
    }
}
