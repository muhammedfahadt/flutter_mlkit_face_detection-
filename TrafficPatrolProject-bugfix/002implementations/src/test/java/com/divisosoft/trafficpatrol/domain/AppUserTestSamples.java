package com.divisosoft.trafficpatrol.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class AppUserTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static AppUser getAppUserSample1() {
        return new AppUser().id(1L).phoneNumber("phoneNumber1").address("address1").pinCode(1L);
    }

    public static AppUser getAppUserSample2() {
        return new AppUser().id(2L).phoneNumber("phoneNumber2").address("address2").pinCode(2L);
    }

    public static AppUser getAppUserRandomSampleGenerator() {
        return new AppUser()
            .id(longCount.incrementAndGet())
            .phoneNumber(UUID.randomUUID().toString())
            .address(UUID.randomUUID().toString())
            .pinCode(longCount.incrementAndGet());
    }
}
