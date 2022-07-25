package shop.seulmeal.config;

import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class Swagger2Config {
	
	@Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder()
                .group("v1-definition")
                .pathsToMatch("/api/v1/community/**")
                .build();
    }
	
	@Bean
    public OpenAPI springShopOpenAPI() {
        return new OpenAPI()
                .info(new Info().title("seulmeal API")
                        .description("슬밀 프로젝트: 밀키트를 판매하는 사이트와 레시피를 공유하는 커뮤니티가 공존하는 seulmeal API")
                        .version("v1.0.0"));
    }
}
