package com.divisosoft.trafficpatrol.service;

import com.divisosoft.trafficpatrol.service.dto.PointsDTO;
import java.util.List;
import java.util.Optional;

/**
 * Service Interface for managing {@link com.divisosoft.trafficpatrol.domain.Points}.
 */
public interface PointsService {
    /**
     * Save a points.
     *
     * @param pointsDTO the entity to save.
     * @return the persisted entity.
     */
    PointsDTO save(PointsDTO pointsDTO);

    /**
     * Updates a points.
     *
     * @param pointsDTO the entity to update.
     * @return the persisted entity.
     */
    PointsDTO update(PointsDTO pointsDTO);

    /**
     * Partially updates a points.
     *
     * @param pointsDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<PointsDTO> partialUpdate(PointsDTO pointsDTO);

    /**
     * Get all the points.
     *
     * @return the list of entities.
     */
    List<PointsDTO> findAll();

    /**
     * Get all the PointsDTO where Violation is {@code null}.
     *
     * @return the {@link List} of entities.
     */
    List<PointsDTO> findAllWhereViolationIsNull();

    /**
     * Get the "id" points.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<PointsDTO> findOne(Long id);

    /**
     * Delete the "id" points.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
