package com.divisosoft.trafficpatrol.web.rest;

import com.divisosoft.trafficpatrol.repository.ViolationRepository;
import com.divisosoft.trafficpatrol.service.ViolationService;
import com.divisosoft.trafficpatrol.service.dto.ViolationDTO;
import com.divisosoft.trafficpatrol.web.rest.errors.BadRequestAlertException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.divisosoft.trafficpatrol.domain.Violation}.
 */
@RestController
@RequestMapping("/api/violations")
public class ViolationResource {

    private final Logger log = LoggerFactory.getLogger(ViolationResource.class);

    private static final String ENTITY_NAME = "violation";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final ViolationService violationService;

    private final ViolationRepository violationRepository;

    public ViolationResource(ViolationService violationService, ViolationRepository violationRepository) {
        this.violationService = violationService;
        this.violationRepository = violationRepository;
    }

    /**
     * {@code POST  /violations} : Create a new violation.
     *
     * @param violationDTO the violationDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new violationDTO, or with status {@code 400 (Bad Request)} if the violation has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<ViolationDTO> createViolation(@RequestBody ViolationDTO violationDTO) throws URISyntaxException {
        log.debug("REST request to save Violation : {}", violationDTO);
        if (violationDTO.getId() != null) {
            throw new BadRequestAlertException("A new violation cannot already have an ID", ENTITY_NAME, "idexists");
        }
        ViolationDTO result = violationService.save(violationDTO);
        return ResponseEntity
            .created(new URI("/api/violations/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /violations/:id} : Updates an existing violation.
     *
     * @param id the id of the violationDTO to save.
     * @param violationDTO the violationDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated violationDTO,
     * or with status {@code 400 (Bad Request)} if the violationDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the violationDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<ViolationDTO> updateViolation(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody ViolationDTO violationDTO
    ) throws URISyntaxException {
        log.debug("REST request to update Violation : {}, {}", id, violationDTO);
        if (violationDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, violationDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!violationRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        ViolationDTO result = violationService.update(violationDTO);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, violationDTO.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /violations/:id} : Partial updates given fields of an existing violation, field will ignore if it is null
     *
     * @param id the id of the violationDTO to save.
     * @param violationDTO the violationDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated violationDTO,
     * or with status {@code 400 (Bad Request)} if the violationDTO is not valid,
     * or with status {@code 404 (Not Found)} if the violationDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the violationDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<ViolationDTO> partialUpdateViolation(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody ViolationDTO violationDTO
    ) throws URISyntaxException {
        log.debug("REST request to partial update Violation partially : {}, {}", id, violationDTO);
        if (violationDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, violationDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!violationRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<ViolationDTO> result = violationService.partialUpdate(violationDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, violationDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /violations} : get all the violations.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of violations in body.
     */
    @GetMapping("")
    public List<ViolationDTO> getAllViolations() {
        log.debug("REST request to get all Violations");
        return violationService.findAll();
    }

    /**
     * {@code GET  /violations/:id} : get the "id" violation.
     *
     * @param id the id of the violationDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the violationDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<ViolationDTO> getViolation(@PathVariable("id") Long id) {
        log.debug("REST request to get Violation : {}", id);
        Optional<ViolationDTO> violationDTO = violationService.findOne(id);
        return ResponseUtil.wrapOrNotFound(violationDTO);
    }

    /**
     * {@code DELETE  /violations/:id} : delete the "id" violation.
     *
     * @param id the id of the violationDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteViolation(@PathVariable("id") Long id) {
        log.debug("REST request to delete Violation : {}", id);
        violationService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
