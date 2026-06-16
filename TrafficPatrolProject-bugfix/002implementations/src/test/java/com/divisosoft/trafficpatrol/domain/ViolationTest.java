package com.divisosoft.trafficpatrol.domain;

import static com.divisosoft.trafficpatrol.domain.AppUserTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ContentTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.PointsTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ViolationTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class ViolationTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Violation.class);
        Violation violation1 = getViolationSample1();
        Violation violation2 = new Violation();
        assertThat(violation1).isNotEqualTo(violation2);

        violation2.setId(violation1.getId());
        assertThat(violation1).isEqualTo(violation2);

        violation2 = getViolationSample2();
        assertThat(violation1).isNotEqualTo(violation2);
    }

    @Test
    void pointsTest() throws Exception {
        Violation violation = getViolationRandomSampleGenerator();
        Points pointsBack = getPointsRandomSampleGenerator();

        violation.setPoints(pointsBack);
        assertThat(violation.getPoints()).isEqualTo(pointsBack);

        violation.points(null);
        assertThat(violation.getPoints()).isNull();
    }

    @Test
    void appUserTest() throws Exception {
        Violation violation = getViolationRandomSampleGenerator();
        AppUser appUserBack = getAppUserRandomSampleGenerator();

        violation.setAppUser(appUserBack);
        assertThat(violation.getAppUser()).isEqualTo(appUserBack);

        violation.appUser(null);
        assertThat(violation.getAppUser()).isNull();
    }

    @Test
    void contentTest() throws Exception {
        Violation violation = getViolationRandomSampleGenerator();
        Content contentBack = getContentRandomSampleGenerator();

        violation.setContent(contentBack);
        assertThat(violation.getContent()).isEqualTo(contentBack);

        violation.content(null);
        assertThat(violation.getContent()).isNull();
    }
}
