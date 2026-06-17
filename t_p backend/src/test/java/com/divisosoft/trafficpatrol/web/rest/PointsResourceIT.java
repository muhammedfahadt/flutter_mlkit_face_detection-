package com.divisosoft.trafficpatrol.web.rest;

import static com.divisosoft.trafficpatrol.web.rest.TestUtil.sameInstant;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.divisosoft.trafficpatrol.IntegrationTest;
import com.divisosoft.trafficpatrol.domain.Points;
import com.divisosoft.trafficpatrol.repository.PointsRepository;
import com.divisosoft.trafficpatrol.service.dto.PointsDTO;
import com.divisosoft.trafficpatrol.service.mapper.PointsMapper;
import jakarta.persistence.EntityManager;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
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
 * Integration tests for the {@link PointsResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class PointsResourceIT {

    private static final Long DEFAULT_POINTS_EARNED = 1L;
    private static final Long UPDATED_POINTS_EARNED = 2L;

    private static final ZonedDateTime DEFAULT_UPLOAD_DATE_TIME = ZonedDateTime.ofInstant(Instant.ofEpochMilli(0L), ZoneOffset.UTC);
    private static final ZonedDateTime UPDATED_UPLOAD_DATE_TIME = ZonedDateTime.now(ZoneId.systemDefault()).withNano(0);

    private static final String ENTITY_API_URL = "/api/points";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private PointsRepository pointsRepository;

    @Autowired
    private PointsMapper pointsMapper;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restPointsMockMvc;

    private Points points;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Points createEntity(EntityManager em) {
        Points points = new Points().pointsEarned(DEFAULT_POINTS_EARNED).uploadDateTime(DEFAULT_UPLOAD_DATE_TIME);
        return points;
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Points createUpdatedEntity(EntityManager em) {
        Points points = new Points().pointsEarned(UPDATED_POINTS_EARNED).uploadDateTime(UPDATED_UPLOAD_DATE_TIME);
        return points;
    }

    @BeforeEach
    public void initTest() {
        points = createEntity(em);
    }

    @Test
    @Transactional
    void createPoints() throws Exception {
        int databaseSizeBeforeCreate = pointsRepository.findAll().size();
        // Create the Points
        PointsDTO pointsDTO = pointsMapper.toDto(points);
        restPointsMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(pointsDTO)))
            .andExpect(status().isCreated());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeCreate + 1);
        Points testPoints = pointsList.get(pointsList.size() - 1);
        assertThat(testPoints.getPointsEarned()).isEqualTo(DEFAULT_POINTS_EARNED);
        assertThat(testPoints.getUploadDateTime()).isEqualTo(DEFAULT_UPLOAD_DATE_TIME);
    }

    @Test
    @Transactional
    void createPointsWithExistingId() throws Exception {
        // Create the Points with an existing ID
        points.setId(1L);
        PointsDTO pointsDTO = pointsMapper.toDto(points);

        int databaseSizeBeforeCreate = pointsRepository.findAll().size();

        // An entity with an existing ID cannot be created, so this API call must fail
        restPointsMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(pointsDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void getAllPoints() throws Exception {
        // Initialize the database
        pointsRepository.saveAndFlush(points);

        // Get all the pointsList
        restPointsMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(points.getId().intValue())))
            .andExpect(jsonPath("$.[*].pointsEarned").value(hasItem(DEFAULT_POINTS_EARNED.intValue())))
            .andExpect(jsonPath("$.[*].uploadDateTime").value(hasItem(sameInstant(DEFAULT_UPLOAD_DATE_TIME))));
    }

    @Test
    @Transactional
    void getPoints() throws Exception {
        // Initialize the database
        pointsRepository.saveAndFlush(points);

        // Get the points
        restPointsMockMvc
            .perform(get(ENTITY_API_URL_ID, points.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(points.getId().intValue()))
            .andExpect(jsonPath("$.pointsEarned").value(DEFAULT_POINTS_EARNED.intValue()))
            .andExpect(jsonPath("$.uploadDateTime").value(sameInstant(DEFAULT_UPLOAD_DATE_TIME)));
    }

    @Test
    @Transactional
    void getNonExistingPoints() throws Exception {
        // Get the points
        restPointsMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingPoints() throws Exception {
        // Initialize the database
        pointsRepository.saveAndFlush(points);

        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();

        // Update the points
        Points updatedPoints = pointsRepository.findById(points.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedPoints are not directly saved in db
        em.detach(updatedPoints);
        updatedPoints.pointsEarned(UPDATED_POINTS_EARNED).uploadDateTime(UPDATED_UPLOAD_DATE_TIME);
        PointsDTO pointsDTO = pointsMapper.toDto(updatedPoints);

        restPointsMockMvc
            .perform(
                put(ENTITY_API_URL_ID, pointsDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(pointsDTO))
            )
            .andExpect(status().isOk());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
        Points testPoints = pointsList.get(pointsList.size() - 1);
        assertThat(testPoints.getPointsEarned()).isEqualTo(UPDATED_POINTS_EARNED);
        assertThat(testPoints.getUploadDateTime()).isEqualTo(UPDATED_UPLOAD_DATE_TIME);
    }

    @Test
    @Transactional
    void putNonExistingPoints() throws Exception {
        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();
        points.setId(longCount.incrementAndGet());

        // Create the Points
        PointsDTO pointsDTO = pointsMapper.toDto(points);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restPointsMockMvc
            .perform(
                put(ENTITY_API_URL_ID, pointsDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(pointsDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchPoints() throws Exception {
        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();
        points.setId(longCount.incrementAndGet());

        // Create the Points
        PointsDTO pointsDTO = pointsMapper.toDto(points);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPointsMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(pointsDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamPoints() throws Exception {
        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();
        points.setId(longCount.incrementAndGet());

        // Create the Points
        PointsDTO pointsDTO = pointsMapper.toDto(points);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPointsMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(pointsDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdatePointsWithPatch() throws Exception {
        // Initialize the database
        pointsRepository.saveAndFlush(points);

        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();

        // Update the points using partial update
        Points partialUpdatedPoints = new Points();
        partialUpdatedPoints.setId(points.getId());

        restPointsMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedPoints.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(partialUpdatedPoints))
            )
            .andExpect(status().isOk());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
        Points testPoints = pointsList.get(pointsList.size() - 1);
        assertThat(testPoints.getPointsEarned()).isEqualTo(DEFAULT_POINTS_EARNED);
        assertThat(testPoints.getUploadDateTime()).isEqualTo(DEFAULT_UPLOAD_DATE_TIME);
    }

    @Test
    @Transactional
    void fullUpdatePointsWithPatch() throws Exception {
        // Initialize the database
        pointsRepository.saveAndFlush(points);

        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();

        // Update the points using partial update
        Points partialUpdatedPoints = new Points();
        partialUpdatedPoints.setId(points.getId());

        partialUpdatedPoints.pointsEarned(UPDATED_POINTS_EARNED).uploadDateTime(UPDATED_UPLOAD_DATE_TIME);

        restPointsMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedPoints.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(partialUpdatedPoints))
            )
            .andExpect(status().isOk());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
        Points testPoints = pointsList.get(pointsList.size() - 1);
        assertThat(testPoints.getPointsEarned()).isEqualTo(UPDATED_POINTS_EARNED);
        assertThat(testPoints.getUploadDateTime()).isEqualTo(UPDATED_UPLOAD_DATE_TIME);
    }

    @Test
    @Transactional
    void patchNonExistingPoints() throws Exception {
        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();
        points.setId(longCount.incrementAndGet());

        // Create the Points
        PointsDTO pointsDTO = pointsMapper.toDto(points);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restPointsMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, pointsDTO.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(pointsDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchPoints() throws Exception {
        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();
        points.setId(longCount.incrementAndGet());

        // Create the Points
        PointsDTO pointsDTO = pointsMapper.toDto(points);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPointsMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(pointsDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamPoints() throws Exception {
        int databaseSizeBeforeUpdate = pointsRepository.findAll().size();
        points.setId(longCount.incrementAndGet());

        // Create the Points
        PointsDTO pointsDTO = pointsMapper.toDto(points);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPointsMockMvc
            .perform(
                patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(TestUtil.convertObjectToJsonBytes(pointsDTO))
            )
            .andExpect(status().isMethodNotAllowed());

        // Validate the Points in the database
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deletePoints() throws Exception {
        // Initialize the database
        pointsRepository.saveAndFlush(points);

        int databaseSizeBeforeDelete = pointsRepository.findAll().size();

        // Delete the points
        restPointsMockMvc
            .perform(delete(ENTITY_API_URL_ID, points.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        List<Points> pointsList = pointsRepository.findAll();
        assertThat(pointsList).hasSize(databaseSizeBeforeDelete - 1);
    }
}
