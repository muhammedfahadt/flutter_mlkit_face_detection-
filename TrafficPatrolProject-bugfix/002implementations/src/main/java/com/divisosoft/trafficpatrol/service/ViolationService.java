package com.divisosoft.trafficpatrol.service;

import com.divisosoft.trafficpatrol.service.dto.ViolationDTO;
import java.util.List;
import java.util.Optional;

/**
 * Service Interface for managing {@link com.divisosoft.trafficpatrol.domain.Violation}.
 */
public interface ViolationService {
    /**
     * Save a violation.
     *
     * @param violationDTO the entity to save.
     * @return the persisted entity.
     */
    ViolationDTO save(ViolationDTO violationDTO);

    /**
     * Updates a violation.
     *
     * @param violationDTO the entity to update.
     * @return the persisted entity.
     */
    ViolationDTO update(ViolationDTO violationDTO);

    /**
     * Partially updates a violation.
     *
     * @param violationDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<ViolationDTO> partialUpdate(ViolationDTO violationDTO);

    /**
     * Get all the violations.
     *
     * @return the list of entities.
     */
    List<ViolationDTO> findAll();

    /**
     * Get the "id" violation.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<ViolationDTO> findOne(Long id);

    /**
     * Delete the "id" violation.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
