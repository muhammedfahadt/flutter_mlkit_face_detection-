package com.divisosoft.trafficpatrol.domain;

import static com.divisosoft.trafficpatrol.domain.ContentBlobTestSamples.*;
import static com.divisosoft.trafficpatrol.domain.ContentTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class ContentBlobTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(ContentBlob.class);
        ContentBlob contentBlob1 = getContentBlobSample1();
        ContentBlob contentBlob2 = new ContentBlob();
        assertThat(contentBlob1).isNotEqualTo(contentBlob2);

        contentBlob2.setId(contentBlob1.getId());
        assertThat(contentBlob1).isEqualTo(contentBlob2);

        contentBlob2 = getContentBlobSample2();
        assertThat(contentBlob1).isNotEqualTo(contentBlob2);
    }

    @Test
    void contentTest() throws Exception {
        ContentBlob contentBlob = getContentBlobRandomSampleGenerator();
        Content contentBack = getContentRandomSampleGenerator();

        contentBlob.setContent(contentBack);
        assertThat(contentBlob.getContent()).isEqualTo(contentBack);

        contentBlob.content(null);
        assertThat(contentBlob.getContent()).isNull();
    }
}
