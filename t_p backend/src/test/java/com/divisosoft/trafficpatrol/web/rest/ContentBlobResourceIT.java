package com.divisosoft.trafficpatrol.web.rest;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.divisosoft.trafficpatrol.IntegrationTest;
import com.divisosoft.trafficpatrol.domain.ContentBlob;
import com.divisosoft.trafficpatrol.repository.ContentBlobRepository;
import com.divisosoft.trafficpatrol.service.dto.ContentBlobDTO;
import com.divisosoft.trafficpatrol.service.mapper.ContentBlobMapper;
import jakarta.persistence.EntityManager;
import java.util.Base64;
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
 * Integration tests for the {@link ContentBlobResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class ContentBlobResourceIT {

    private static final byte[] DEFAULT_CONTENT_BLOB = TestUtil.createByteArray(1, "0");
    private static final byte[] UPDATED_CONTENT_BLOB = TestUtil.createByteArray(1, "1");
    private static final String DEFAULT_CONTENT_BLOB_CONTENT_TYPE = "image/jpg";
    private static final String UPDATED_CONTENT_BLOB_CONTENT_TYPE = "image/png";

    private static final String ENTITY_API_URL = "/api/content-blobs";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ContentBlobRepository contentBlobRepository;

    @Autowired
    private ContentBlobMapper contentBlobMapper;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restContentBlobMockMvc;

    private ContentBlob contentBlob;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static ContentBlob createEntity(EntityManager em) {
        ContentBlob contentBlob = new ContentBlob()
            .contentBlob(DEFAULT_CONTENT_BLOB)
            .contentBlobContentType(DEFAULT_CONTENT_BLOB_CONTENT_TYPE);
        return contentBlob;
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static ContentBlob createUpdatedEntity(EntityManager em) {
        ContentBlob contentBlob = new ContentBlob()
            .contentBlob(UPDATED_CONTENT_BLOB)
            .contentBlobContentType(UPDATED_CONTENT_BLOB_CONTENT_TYPE);
        return contentBlob;
    }

    @BeforeEach
    public void initTest() {
        contentBlob = createEntity(em);
    }

    @Test
    @Transactional
    void createContentBlob() throws Exception {
        int databaseSizeBeforeCreate = contentBlobRepository.findAll().size();
        // Create the ContentBlob
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);
        restContentBlobMockMvc
            .perform(
                post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isCreated());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeCreate + 1);
        ContentBlob testContentBlob = contentBlobList.get(contentBlobList.size() - 1);
        assertThat(testContentBlob.getContentBlob()).isEqualTo(DEFAULT_CONTENT_BLOB);
        assertThat(testContentBlob.getContentBlobContentType()).isEqualTo(DEFAULT_CONTENT_BLOB_CONTENT_TYPE);
    }

    @Test
    @Transactional
    void createContentBlobWithExistingId() throws Exception {
        // Create the ContentBlob with an existing ID
        contentBlob.setId(1L);
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);

        int databaseSizeBeforeCreate = contentBlobRepository.findAll().size();

        // An entity with an existing ID cannot be created, so this API call must fail
        restContentBlobMockMvc
            .perform(
                post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void getAllContentBlobs() throws Exception {
        // Initialize the database
        contentBlobRepository.saveAndFlush(contentBlob);

        // Get all the contentBlobList
        restContentBlobMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(contentBlob.getId().intValue())))
            .andExpect(jsonPath("$.[*].contentBlobContentType").value(hasItem(DEFAULT_CONTENT_BLOB_CONTENT_TYPE)))
            .andExpect(jsonPath("$.[*].contentBlob").value(hasItem(Base64.getEncoder().encodeToString(DEFAULT_CONTENT_BLOB))));
    }

    @Test
    @Transactional
    void getContentBlob() throws Exception {
        // Initialize the database
        contentBlobRepository.saveAndFlush(contentBlob);

        // Get the contentBlob
        restContentBlobMockMvc
            .perform(get(ENTITY_API_URL_ID, contentBlob.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(contentBlob.getId().intValue()))
            .andExpect(jsonPath("$.contentBlobContentType").value(DEFAULT_CONTENT_BLOB_CONTENT_TYPE))
            .andExpect(jsonPath("$.contentBlob").value(Base64.getEncoder().encodeToString(DEFAULT_CONTENT_BLOB)));
    }

    @Test
    @Transactional
    void getNonExistingContentBlob() throws Exception {
        // Get the contentBlob
        restContentBlobMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingContentBlob() throws Exception {
        // Initialize the database
        contentBlobRepository.saveAndFlush(contentBlob);

        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();

        // Update the contentBlob
        ContentBlob updatedContentBlob = contentBlobRepository.findById(contentBlob.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedContentBlob are not directly saved in db
        em.detach(updatedContentBlob);
        updatedContentBlob.contentBlob(UPDATED_CONTENT_BLOB).contentBlobContentType(UPDATED_CONTENT_BLOB_CONTENT_TYPE);
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(updatedContentBlob);

        restContentBlobMockMvc
            .perform(
                put(ENTITY_API_URL_ID, contentBlobDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isOk());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
        ContentBlob testContentBlob = contentBlobList.get(contentBlobList.size() - 1);
        assertThat(testContentBlob.getContentBlob()).isEqualTo(UPDATED_CONTENT_BLOB);
        assertThat(testContentBlob.getContentBlobContentType()).isEqualTo(UPDATED_CONTENT_BLOB_CONTENT_TYPE);
    }

    @Test
    @Transactional
    void putNonExistingContentBlob() throws Exception {
        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();
        contentBlob.setId(longCount.incrementAndGet());

        // Create the ContentBlob
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restContentBlobMockMvc
            .perform(
                put(ENTITY_API_URL_ID, contentBlobDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchContentBlob() throws Exception {
        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();
        contentBlob.setId(longCount.incrementAndGet());

        // Create the ContentBlob
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restContentBlobMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamContentBlob() throws Exception {
        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();
        contentBlob.setId(longCount.incrementAndGet());

        // Create the ContentBlob
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restContentBlobMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(TestUtil.convertObjectToJsonBytes(contentBlobDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateContentBlobWithPatch() throws Exception {
        // Initialize the database
        contentBlobRepository.saveAndFlush(contentBlob);

        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();

        // Update the contentBlob using partial update
        ContentBlob partialUpdatedContentBlob = new ContentBlob();
        partialUpdatedContentBlob.setId(contentBlob.getId());

        restContentBlobMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedContentBlob.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(partialUpdatedContentBlob))
            )
            .andExpect(status().isOk());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
        ContentBlob testContentBlob = contentBlobList.get(contentBlobList.size() - 1);
        assertThat(testContentBlob.getContentBlob()).isEqualTo(DEFAULT_CONTENT_BLOB);
        assertThat(testContentBlob.getContentBlobContentType()).isEqualTo(DEFAULT_CONTENT_BLOB_CONTENT_TYPE);
    }

    @Test
    @Transactional
    void fullUpdateContentBlobWithPatch() throws Exception {
        // Initialize the database
        contentBlobRepository.saveAndFlush(contentBlob);

        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();

        // Update the contentBlob using partial update
        ContentBlob partialUpdatedContentBlob = new ContentBlob();
        partialUpdatedContentBlob.setId(contentBlob.getId());

        partialUpdatedContentBlob.contentBlob(UPDATED_CONTENT_BLOB).contentBlobContentType(UPDATED_CONTENT_BLOB_CONTENT_TYPE);

        restContentBlobMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedContentBlob.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(partialUpdatedContentBlob))
            )
            .andExpect(status().isOk());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
        ContentBlob testContentBlob = contentBlobList.get(contentBlobList.size() - 1);
        assertThat(testContentBlob.getContentBlob()).isEqualTo(UPDATED_CONTENT_BLOB);
        assertThat(testContentBlob.getContentBlobContentType()).isEqualTo(UPDATED_CONTENT_BLOB_CONTENT_TYPE);
    }

    @Test
    @Transactional
    void patchNonExistingContentBlob() throws Exception {
        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();
        contentBlob.setId(longCount.incrementAndGet());

        // Create the ContentBlob
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restContentBlobMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, contentBlobDTO.getId())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchContentBlob() throws Exception {
        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();
        contentBlob.setId(longCount.incrementAndGet());

        // Create the ContentBlob
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restContentBlobMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamContentBlob() throws Exception {
        int databaseSizeBeforeUpdate = contentBlobRepository.findAll().size();
        contentBlob.setId(longCount.incrementAndGet());

        // Create the ContentBlob
        ContentBlobDTO contentBlobDTO = contentBlobMapper.toDto(contentBlob);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restContentBlobMockMvc
            .perform(
                patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(TestUtil.convertObjectToJsonBytes(contentBlobDTO))
            )
            .andExpect(status().isMethodNotAllowed());

        // Validate the ContentBlob in the database
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteContentBlob() throws Exception {
        // Initialize the database
        contentBlobRepository.saveAndFlush(contentBlob);

        int databaseSizeBeforeDelete = contentBlobRepository.findAll().size();

        // Delete the contentBlob
        restContentBlobMockMvc
            .perform(delete(ENTITY_API_URL_ID, contentBlob.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        List<ContentBlob> contentBlobList = contentBlobRepository.findAll();
        assertThat(contentBlobList).hasSize(databaseSizeBeforeDelete - 1);
    }
}
