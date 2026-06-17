package com.divisosoft.trafficpatrol.domain;

import static com.divisosoft.trafficpatrol.domain.AppUserTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.PointsTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ViolationTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class PointsTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Points.class);
        Points points1 = getPointsSample1();
        Points points2 = new Points();
        assertThat(points1).isNotEqualTo(points2);

        points2.setId(points1.getId());
        assertThat(points1).isEqualTo(points2);

        points2 = getPointsSample2();
        assertThat(points1).isNotEqualTo(points2);
    }

    @Test
    void violationTest() throws Exception {
        Points points = getPointsRandomSampleGenerator();
        Violation violationBack = getViolationRandomSampleGenerator();

        points.setViolation(violationBack);
        assertThat(points.getViolation()).isEqualTo(violationBack);
        assertThat(violationBack.getPoints()).isEqualTo(points);

        points.violation(null);
        assertThat(points.getViolation()).isNull();
        assertThat(violationBack.getPoints()).isNull();
    }

    @Test
    void appUserTest() throws Exception {
        Points points = getPointsRandomSampleGenerator();
        AppUser appUserBack = getAppUserRandomSampleGenerator();

        points.setAppUser(appUserBack);
        assertThat(points.getAppUser()).isEqualTo(appUserBack);

        points.appUser(null);
        assertThat(points.getAppUser()).isNull();
    }
}
