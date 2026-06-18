package com.divisosoft.trafficpatrol.service;

import com.divisosoft.trafficpatrol.service.dto.AppUserDTO;
import java.util.List;
import java.util.Optional;

/**
 * Service Interface for managing {@link com.divisosoft.trafficpatrol.domain.AppUser}.
 */
public interface AppUserService {
    /**
     * Save a appUser.
     *
     * @param appUserDTO the entity to save.
     * @return the persisted entity.
     */
    AppUserDTO save(AppUserDTO appUserDTO);

    /**
     * Updates a appUser.
     *
     * @param appUserDTO the entity to update.
     * @return the persisted entity.
     */
    AppUserDTO update(AppUserDTO appUserDTO);

    /**
     * Partially updates a appUser.
     *
     * @param appUserDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<AppUserDTO> partialUpdate(AppUserDTO appUserDTO);

    /**
     * Get all the appUsers.
     *
     * @return the list of entities.
     */
    List<AppUserDTO> findAll();

    /**
     * Get the "id" appUser.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<AppUserDTO> findOne(Long id);

    /**
     * Delete the "id" appUser.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
