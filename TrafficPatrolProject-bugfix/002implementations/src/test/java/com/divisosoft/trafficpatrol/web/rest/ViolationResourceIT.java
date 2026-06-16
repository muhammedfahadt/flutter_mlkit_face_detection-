package com.divisosoft.trafficpatrol.web.rest;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.divisosoft.trafficpatrol.IntegrationTest;
import com.divisosoft.trafficpatrol.domain.Violation;
import com.divisosoft.trafficpatrol.repository.ViolationRepository;
import com.divisosoft.trafficpatrol.service.dto.ViolationDTO;
import com.divisosoft.trafficpatrol.service.mapper.ViolationMapper;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicLong;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

/**
 * Integration tests for the {@link ViolationResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class ViolationResourceIT {

    private static final String DEFAULT_VIOLATION_TYPE = "AAAAAAAAAA";
    private static final String UPDATED_VIOLATION_TYPE = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/violations";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ViolationRepository violationRepository;

    @Autowired
    private ViolationMapper violationMapper;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restViolationMockMvc;

    private Violation violation;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Violation createEntity(EntityManager em) {
        Violation violation = new Violation().violationType(DEFAULT_VIOLATION_TYPE);
        return violation;
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Violation createUpdatedEntity(EntityManager em) {
        Violation violation = new Violation().violationType(UPDATED_VIOLATION_TYPE);
        return violation;
    }

    @BeforeEach
    public void initTest() {
        violation = createEntity(em);
    }

    @Test
    @Transactional
    void createViolation() throws Exception {
        int databaseSizeBeforeCreate = violationRepository.findAll().size();
        // Create the Violation
        ViolationDTO violationDTO = violationMapper.toDto(violation);
        restViolationMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(violationDTO)))
            .andExpect(status().isCreated());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeCreate + 1);
        Violation testViolation = violationList.get(violationList.size() - 1);
        assertThat(testViolation.getViolationType()).isEqualTo(DEFAULT_VIOLATION_TYPE);
    }

    @Test
    @Transactional
    void createViolationWithExistingId() throws Exception {
        // Create the Violation with an existing ID
        violation.setId(1L);
        ViolationDTO violationDTO = violationMapper.toDto(violation);

        int databaseSizeBeforeCreate = violationRepository.findAll().size();

        // An entity with an existing ID cannot be created, so this API call must fail
        restViolationMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(violationDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void getAllViolations() throws Exception {
        // Initialize the database
        violationRepository.saveAndFlush(violation);

        // Get all the violationList
        restViolationMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(violation.getId().intValue())))
            .andExpect(jsonPath("$.[*].violationType").value(hasItem(DEFAULT_VIOLATION_TYPE)));
    }

    @Test
    @Transactional
    void getViolation() throws Exception {
        // Initialize the database
        violationRepository.saveAndFlush(violation);

        // Get the violation
        restViolationMockMvc
            .perform(get(ENTITY_API_URL_ID, violation.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(violation.getId().intValue()))
            .andExpect(jsonPath("$.violationType").value(DEFAULT_VIOLATION_TYPE));
    }

    @Test
    @Transactional
    void getNonExistingViolation() throws Exception {
        // Get the violation
        restViolationMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingViolation() throws Exception {
        // Initialize the database
        violationRepository.saveAndFlush(violation);

        int databaseSizeBeforeUpdate = violationRepository.findAll().size();

        // Update the violation
        Violation updatedViolation = violationRepository.findById(violation.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedViolation are not directly saved in db
        em.detach(updatedViolation);
        updatedViolation.violationType(UPDATED_VIOLATION_TYPE);
        ViolationDTO violationDTO = violationMapper.toDto(updatedViolation);

        restViolationMockMvc
            .perform(
                put(ENTITY_API_URL_ID, violationDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(violationDTO))
            )
            .andExpect(status().isOk());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
        Violation testViolation = violationList.get(violationList.size() - 1);
        assertThat(testViolation.getViolationType()).isEqualTo(UPDATED_VIOLATION_TYPE);
    }

    @Test
    @Transactional
    void putNonExistingViolation() throws Exception {
        int databaseSizeBeforeUpdate = violationRepository.findAll().size();
        violation.setId(longCount.incrementAndGet());

        // Create the Violation
        ViolationDTO violationDTO = violationMapper.toDto(violation);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restViolationMockMvc
            .perform(
                put(ENTITY_API_URL_ID, violationDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(violationDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchViolation() throws Exception {
        int databaseSizeBeforeUpdate = violationRepository.findAll().size();
        violation.setId(longCount.incrementAndGet());

        // Create the Violation
        ViolationDTO violationDTO = violationMapper.toDto(violation);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restViolationMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(violationDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamViolation() throws Exception {
        int databaseSizeBeforeUpdate = violationRepository.findAll().size();
        violation.setId(longCount.incrementAndGet());

        // Create the Violation
        ViolationDTO violationDTO = violationMapper.toDto(violation);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restViolationMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(violationDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateViolationWithPatch() throws Exception {
        // Initialize the database
        violationRepository.saveAndFlush(violation);

        int databaseSizeBeforeUpdate = violationRepository.findAll().size();

        // Update the violation using partial update
        Violation partialUpdatedViolation = new Violation();
        partialUpdatedViolation.setId(violation.getId());

        restViolationMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedViolation.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(partialUpdatedViolation))
            )
            .andExpect(status().isOk());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
        Violation testViolation = violationList.get(violationList.size() - 1);
        assertThat(testViolation.getViolationType()).isEqualTo(DEFAULT_VIOLATION_TYPE);
    }

    @Test
    @Transactional
    void fullUpdateViolationWithPatch() throws Exception {
        // Initialize the database
        violationRepository.saveAndFlush(violation);

        int databaseSizeBeforeUpdate = violationRepository.findAll().size();

        // Update the violation using partial update
        Violation partialUpdatedViolation = new Violation();
        partialUpdatedViolation.setId(violation.getId());

        partialUpdatedViolation.violationType(UPDATED_VIOLATION_TYPE);

        restViolationMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedViolation.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(partialUpdatedViolation))
            )
            .andExpect(status().isOk());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
        Violation testViolation = violationList.get(violationList.size() - 1);
        assertThat(testViolation.getViolationType()).isEqualTo(UPDATED_VIOLATION_TYPE);
    }

    @Test
    @Transactional
    void patchNonExistingViolation() throws Exception {
        int databaseSizeBeforeUpdate = violationRepository.findAll().size();
        violation.setId(longCount.incrementAndGet());

        // Create the Violation
        ViolationDTO violationDTO = violationMapper.toDto(violation);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restViolationMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, violationDTO.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(violationDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchViolation() throws Exception {
        int databaseSizeBeforeUpdate = violationRepository.findAll().size();
        violation.setId(longCount.incrementAndGet());

        // Create the Violation
        ViolationDTO violationDTO = violationMapper.toDto(violation);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restViolationMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(violationDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamViolation() throws Exception {
        int databaseSizeBeforeUpdate = violationRepository.findAll().size();
        violation.setId(longCount.incrementAndGet());

        // Create the Violation
        ViolationDTO violationDTO = violationMapper.toDto(violation);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restViolationMockMvc
            .perform(
                patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(TestUtil.convertObjectToJsonBytes(violationDTO))
            )
            .andExpect(status().isMethodNotAllowed());

        // Validate the Violation in the database
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteViolation() throws Exception {
        // Initialize the database
        violationRepository.saveAndFlush(violation);

        int databaseSizeBeforeDelete = violationRepository.findAll().size();

        // Delete the violation
        restViolationMockMvc
            .perform(delete(ENTITY_API_URL_ID, violation.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        List<Violation> violationList = violationRepository.findAll();
        assertThat(violationList).hasSize(databaseSizeBeforeDelete - 1);
    }
}
