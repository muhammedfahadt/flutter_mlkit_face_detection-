package com.divisosoft.trafficpatrol.service.dto;

import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class ContentBlobDTOTest {

    @Test
    void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ContentBlobDTO.class);
        ContentBlobDTO contentBlobDTO1 = new ContentBlobDTO();
        contentBlobDTO1.setId(1L);
        ContentBlobDTO contentBlobDTO2 = new ContentBlobDTO();
        assertThat(contentBlobDTO1).isNotEqualTo(contentBlobDTO2);
        contentBlobDTO2.setId(contentBlobDTO1.getId());
        assertThat(contentBlobDTO1).isEqualTo(contentBlobDTO2);
        contentBlobDTO2.setId(2L);
        assertThat(contentBlobDTO1).isNotEqualTo(contentBlobDTO2);
        contentBlobDTO1.setId(null);
        assertThat(contentBlobDTO1).isNotEqualTo(contentBlobDTO2);
    }
}
