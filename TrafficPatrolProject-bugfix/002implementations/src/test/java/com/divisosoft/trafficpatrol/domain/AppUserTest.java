package com.divisosoft.trafficpatrol.domain;

import static com.divisosoft.trafficpatrol.domain.AppUserTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ContentTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.PointsTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ViolationTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import java.util.HashSet;
import java.util.Set;
import org.junit.jupiter.api.Test;

class AppUserTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(AppUser.class);
        AppUser appUser1 = getAppUserSample1();
        AppUser appUser2 = new AppUser();
        assertThat(appUser1).isNotEqualTo(appUser2);

        appUser2.setId(appUser1.getId());
        assertThat(appUser1).isEqualTo(appUser2);

        appUser2 = getAppUserSample2();
        assertThat(appUser1).isNotEqualTo(appUser2);
    }

    @Test
    void contentsTest() throws Exception {
        AppUser appUser = getAppUserRandomSampleGenerator();
        Content contentBack = getContentRandomSampleGenerator();

        appUser.addContents(contentBack);
        assertThat(appUser.getContents()).containsOnly(contentBack);
        assertThat(contentBack.getAppUser()).isEqualTo(appUser);

        appUser.removeContents(contentBack);
        assertThat(appUser.getContents()).doesNotContain(contentBack);
        assertThat(contentBack.getAppUser()).isNull();

        appUser.contents(new HashSet<>(Set.of(contentBack)));
        assertThat(appUser.getContents()).containsOnly(contentBack);
        assertThat(contentBack.getAppUser()).isEqualTo(appUser);

        appUser.setContents(new HashSet<>());
        assertThat(appUser.getContents()).doesNotContain(contentBack);
        assertThat(contentBack.getAppUser()).isNull();
    }

    @Test
    void pointsTest() throws Exception {
        AppUser appUser = getAppUserRandomSampleGenerator();
        Points pointsBack = getPointsRandomSampleGenerator();

        appUser.addPoints(pointsBack);
        assertThat(appUser.getPoints()).containsOnly(pointsBack);
        assertThat(pointsBack.getAppUser()).isEqualTo(appUser);

        appUser.removePoints(pointsBack);
        assertThat(appUser.getPoints()).doesNotContain(pointsBack);
        assertThat(pointsBack.getAppUser()).isNull();

        appUser.points(new HashSet<>(Set.of(pointsBack)));
        assertThat(appUser.getPoints()).containsOnly(pointsBack);
        assertThat(pointsBack.getAppUser()).isEqualTo(appUser);

        appUser.setPoints(new HashSet<>());
        assertThat(appUser.getPoints()).doesNotContain(pointsBack);
        assertThat(pointsBack.getAppUser()).isNull();
    }

    @Test
    void violationsTest() throws Exception {
        AppUser appUser = getAppUserRandomSampleGenerator();
        Violation violationBack = getViolationRandomSampleGenerator();

        appUser.addViolations(violationBack);
        assertThat(appUser.getViolations()).containsOnly(violationBack);
        assertThat(violationBack.getAppUser()).isEqualTo(appUser);

        appUser.removeViolations(violationBack);
        assertThat(appUser.getViolations()).doesNotContain(violationBack);
        assertThat(violationBack.getAppUser()).isNull();

        appUser.violations(new HashSet<>(Set.of(violationBack)));
        assertThat(appUser.getViolations()).containsOnly(violationBack);
        assertThat(violationBack.getAppUser()).isEqualTo(appUser);

        appUser.setViolations(new HashSet<>());
        assertThat(appUser.getViolations()).doesNotContain(violationBack);
        assertThat(violationBack.getAppUser()).isNull();
    }
}
