package com.divisosoft.trafficpatrol.domain;

import java.util.Random;
import java.util.concurrent.atomic.AtomicLong;

public class PointsTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static Points getPointsSample1() {
        return new Points().id(1L).pointsEarned(1L);
    }

    public static Points getPointsSample2() {
        return new Points().id(2L).pointsEarned(2L);
    }

    public static Points getPointsRandomSampleGenerator() {
        return new Points().id(longCount.incrementAndGet()).pointsEarned(longCount.incrementAndGet());
    }
}
