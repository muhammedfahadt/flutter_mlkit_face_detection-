package com.divisosoft.trafficpatrol.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class ViolationTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static Violation getViolationSample1() {
        return new Violation().id(1L).violationType("violationType1");
    }

    public static Violation getViolationSample2() {
        return new Violation().id(2L).violationType("violationType2");
    }

    public static Violation getViolationRandomSampleGenerator() {
        return new Violation().id(longCount.incrementAndGet()).violationType(UUID.randomUUID().toString());
    }
}
