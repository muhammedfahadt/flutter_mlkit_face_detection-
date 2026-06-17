package com.divisosoft.trafficpatrol.domain;

import static com.divisosoft.trafficpatrol.domain.AppUserTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ContentBlobTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ContentTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ViolationTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import java.util.HashSet;
import java.util.Set;
import org.junit.jupiter.api.Test;

class ContentTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Content.class);
        Content content1 = getContentSample1();
        Content content2 = new Content();
        assertThat(content1).isNotEqualTo(content2);

        content2.setId(content1.getId());
        assertThat(content1).isEqualTo(content2);

        content2 = getContentSample2();
        assertThat(content1).isNotEqualTo(content2);
    }

    @Test
    void contentBlobTest() throws Exception {
        Content content = getContentRandomSampleGenerator();
        ContentBlob contentBlobBack = getContentBlobRandomSampleGenerator();

        content.addContentBlob(contentBlobBack);
        assertThat(content.getContentBlobs()).containsOnly(contentBlobBack);
        assertThat(contentBlobBack.getContent()).isEqualTo(content);

        content.removeContentBlob(contentBlobBack);
        assertThat(content.getContentBlobs()).doesNotContain(contentBlobBack);
        assertThat(contentBlobBack.getContent()).isNull();

        content.contentBlobs(new HashSet<>(Set.of(contentBlobBack)));
        assertThat(content.getContentBlobs()).containsOnly(contentBlobBack);
        assertThat(contentBlobBack.getContent()).isEqualTo(content);

        content.setContentBlobs(new HashSet<>());
        assertThat(content.getContentBlobs()).doesNotContain(contentBlobBack);
        assertThat(contentBlobBack.getContent()).isNull();
    }

    @Test
    void violationsTest() throws Exception {
        Content content = getContentRandomSampleGenerator();
        Violation violationBack = getViolationRandomSampleGenerator();

        content.addViolations(violationBack);
        assertThat(content.getViolations()).containsOnly(violationBack);
        assertThat(violationBack.getContent()).isEqualTo(content);

        content.removeViolations(violationBack);
        assertThat(content.getViolations()).doesNotContain(violationBack);
        assertThat(violationBack.getContent()).isNull();

        content.violations(new HashSet<>(Set.of(violationBack)));
        assertThat(content.getViolations()).containsOnly(violationBack);
        assertThat(violationBack.getContent()).isEqualTo(content);

        content.setViolations(new HashSet<>());
        assertThat(content.getViolations()).doesNotContain(violationBack);
        assertThat(violationBack.getContent()).isNull();
    }

    @Test
    void appUserTest() throws Exception {
        Content content = getContentRandomSampleGenerator();
        AppUser appUserBack = getAppUserRandomSampleGenerator();

        content.setAppUser(appUserBack);
        assertThat(content.getAppUser()).isEqualTo(appUserBack);

        content.appUser(null);
        assertThat(content.getAppUser()).isNull();
    }
}
