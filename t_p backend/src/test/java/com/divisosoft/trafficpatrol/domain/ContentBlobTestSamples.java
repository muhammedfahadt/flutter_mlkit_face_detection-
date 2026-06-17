package com.divisosoft.trafficpatrol.domain;

import java.util.Random;
import java.util.concurrent.atomic.AtomicLong;

public class ContentBlobTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static ContentBlob getContentBlobSample1() {
        return new ContentBlob().id(1L);
    }

    public static ContentBlob getContentBlobSample2() {
        return new ContentBlob().id(2L);
    }

    public static ContentBlob getContentBlobRandomSampleGenerator() {
        return new ContentBlob().id(longCount.incrementAndGet());
    }
}
