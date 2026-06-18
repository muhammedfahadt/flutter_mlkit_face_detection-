package com.divisosoft.trafficpatrol.service;

import com.divisosoft.trafficpatrol.service.dto.ContentBlobDTO;
import java.util.List;
import java.util.Optional;

/**
 * Service Interface for managing {@link com.divisosoft.trafficpatrol.domain.ContentBlob}.
 */
public interface ContentBlobService {
    /**
     * Save a contentBlob.
     *
     * @param contentBlobDTO the entity to save.
     * @return the persisted entity.
     */
    ContentBlobDTO save(ContentBlobDTO contentBlobDTO);

    /**
     * Updates a contentBlob.
     *
     * @param contentBlobDTO the entity to update.
     * @return the persisted entity.
     */
    ContentBlobDTO update(ContentBlobDTO contentBlobDTO);

    /**
     * Partially updates a contentBlob.
     *
     * @param contentBlobDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<ContentBlobDTO> partialUpdate(ContentBlobDTO contentBlobDTO);

    /**
     * Get all the contentBlobs.
     *
     * @return the list of entities.
     */
    List<ContentBlobDTO> findAll();

    /**
     * Get the "id" contentBlob.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<ContentBlobDTO> findOne(Long id);

    /**
     * Delete the "id" contentBlob.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
