package com.infraReport.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
public class TilesConfig {

    @Bean
    public TilesConfigurer tilesConfigurer() {
        TilesConfigurer tilesConfigurer = new TilesConfigurer();
        tilesConfigurer.setDefinitions("/WEB-INF/tiles/tiles.xml");
//        tilesConfigurer.setCheckRefresh(true);
        return tilesConfigurer;
    }
  
    @Bean
    public TilesViewResolver tilesViewResolver() {
        TilesViewResolver resolver = new TilesViewResolver();
        resolver.setOrder(0);
        return resolver;
    }
}
