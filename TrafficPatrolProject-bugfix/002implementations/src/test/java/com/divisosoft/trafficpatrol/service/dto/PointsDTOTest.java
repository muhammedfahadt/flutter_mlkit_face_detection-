package com.divisosoft.trafficpatrol.service.dto;

import static org.assertj.core.api.Assertions.assertThat;

import com.divisosoft.trafficpatrol.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class PointsDTOTest {

    @Test
    void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(PointsDTO.class);
        PointsDTO pointsDTO1 = new PointsDTO();
        pointsDTO1.setId(1L);
        PointsDTO pointsDTO2 = new PointsDTO();
        assertThat(pointsDTO1).isNotEqualTo(pointsDTO2);
        pointsDTO2.setId(pointsDTO1.getId());
        assertThat(pointsDTO1).isEqualTo(pointsDTO2);
        pointsDTO2.setId(2L);
        assertThat(pointsDTO1).isNotEqualTo(pointsDTO2);
        pointsDTO1.setId(null);
        assertThat(pointsDTO1).isNotEqualTo(pointsDTO2);
    }
}
