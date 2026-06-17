package com.divisosoft.trafficpatrol.service.dto;

import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class ViolationDTOTest {

    @Test
    void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ViolationDTO.class);
        ViolationDTO violationDTO1 = new ViolationDTO();
        violationDTO1.setId(1L);
        ViolationDTO violationDTO2 = new ViolationDTO();
        assertThat(violationDTO1).isNotEqualTo(violationDTO2);
        violationDTO2.setId(violationDTO1.getId());
        assertThat(violationDTO1).isEqualTo(violationDTO2);
        violationDTO2.setId(2L);
        assertThat(violationDTO1).isNotEqualTo(violationDTO2);
        violationDTO1.setId(null);
        assertThat(violationDTO1).isNotEqualTo(violationDTO2);
    }
}
