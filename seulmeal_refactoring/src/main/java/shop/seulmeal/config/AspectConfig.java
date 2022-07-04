package shop.seulmeal.config;

import java.util.Collections;
import java.util.HashMap;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.interceptor.NameMatchTransactionAttributeSource;
import org.springframework.transaction.interceptor.RollbackRuleAttribute;
import org.springframework.transaction.interceptor.RuleBasedTransactionAttribute;
import org.springframework.transaction.interceptor.TransactionAttribute;
import org.springframework.transaction.interceptor.TransactionInterceptor;
import org.springframework.util.StopWatch;

@Aspect
@Component
@Configuration
public class AspectConfig {

    private static final Logger LOGGER = LoggerFactory.getLogger(AspectConfig.class);
    
    @Autowired
    private PlatformTransactionManager transactionManager; 

    

    /**
     *   @GetMapping 설정된 메소드 또는 클래스 설정
     *   GetMapping 노테이션이 설정된 특정 클래스/메소드에만 AspectJ가 적용됨.
     */
    @Pointcut("execution(* shop.seulmeal.service..impl.*(..))")
    //@Pointcut("@annotation(org.springframework.web.bind.annotation.GetMapping)")
    public void joinCut(){ }

    /**
     * @param joinPoint
     */
    @Before("joinCut()")
    public void before(JoinPoint joinPoint) {
        LOGGER.info("=====================AspectJ  : Before Logging Start=====================");
        LOGGER.info("=====================AspectJ  : Before Logging End=====================");
    }

    /**
     * @param joinPoint
     * @param result
     */
    @AfterReturning(pointcut = "joinCut()", returning = "result")
    public void AfterReturning(JoinPoint joinPoint, Object result) {
        LOGGER.info("=====================AspectJ  : AfterReturning Logging Start=====================");
        LOGGER.info("=====================AspectJ  : AfterReturning Logging END=====================");
    }
    
    @AfterThrowing(pointcut = "joinCut()", throwing ="ex")
    public void AfterThrowing(JoinPoint joinPoint, Throwable ex) {
    	System.out.println("============ 타겟메소드 예외 설정 : "
    	        + joinPoint.getSignature().toShortString()+"========================================");
    }

    /**
     *
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("joinCut()")
    public Object Around(ProceedingJoinPoint joinPoint) throws Throwable {
        LOGGER.info("=====================AspectJ  : Around Logging Start=====================");
        StopWatch sw = new StopWatch();
        sw.start();
        
        
        try {
            Object result = joinPoint.proceed();
            sw.stop();
            
            LOGGER.info("성능 측정이 끝났습니다.");
            LOGGER.info("걸린시간: {} ms", sw.getLastTaskTimeMillis());
            
            return result;
        }catch (Exception e) {
            LOGGER.error("=====================AspectJ Around Exception=====================");
            LOGGER.error(e.toString());
            return null;
        }
    }
    
    @Bean
    public TransactionInterceptor transactionAdvice() {
    	LOGGER.debug("=====================transactionAdivce() start=========================");
    	TransactionInterceptor txAdvice = new TransactionInterceptor();
    	NameMatchTransactionAttributeSource txAttributeSource = new NameMatchTransactionAttributeSource();
    	RuleBasedTransactionAttribute txAttribute = new RuleBasedTransactionAttribute();
    
    	txAttribute.setRollbackRules(Collections.singletonList(new RollbackRuleAttribute(Exception.class)));
    	txAttribute.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
    	
    	HashMap<String,TransactionAttribute> txMethods = new HashMap<String,TransactionAttribute>();
    	txMethods.put("*", txAttribute);
    	txAttributeSource.setNameMap(txMethods);

    	txAdvice.setTransactionAttributeSource(txAttributeSource);
    	txAdvice.setTransactionManager(transactionManager);
    	
    	LOGGER.debug("=====================transactionAdivce() end=========================");
    	
        return txAdvice;
    }

 

    @Bean
    public Advisor transactionAdviceAdvisor() {
    	LOGGER.debug("===================transactionAdviceAdvisor() start=======================");
        AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
        pointcut.setExpression("execution(* shop.seulmeal.service..impl.*(..))");
        LOGGER.debug("===================transactionAdviceAdvisor() end=======================");
        
        return new DefaultPointcutAdvisor(pointcut, transactionAdvice());
    }

}