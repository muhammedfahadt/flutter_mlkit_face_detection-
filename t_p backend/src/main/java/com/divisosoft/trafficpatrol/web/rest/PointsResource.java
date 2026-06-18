package com.divisosoft.trafficpatrol.web.rest;

import com.divisosoft.trafficpatrol.repository.PointsRepository;
import com.divisosoft.trafficpatrol.service.PointsService;
import com.divisosoft.trafficpatrol.service.dto.PointsDTO;
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
 * REST controller for managing {@link com.divisosoft.trafficpatrol.domain.Points}.
 */
@RestController
@RequestMapping("/api/points")
public class PointsResource {

    private final Logger log = LoggerFactory.getLogger(PointsResource.class);

    private static final String ENTITY_NAME = "points";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final PointsService pointsService;

    private final PointsRepository pointsRepository;

    public PointsResource(PointsService pointsService, PointsRepository pointsRepository) {
        this.pointsService = pointsService;
        this.pointsRepository = pointsRepository;
    }

    /**
     * {@code POST  /points} : Create a new points.
     *
     * @param pointsDTO the pointsDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new pointsDTO, or with status {@code 400 (Bad Request)} if the points has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<PointsDTO> createPoints(@RequestBody PointsDTO pointsDTO) throws URISyntaxException {
        log.debug("REST request to save Points : {}", pointsDTO);
        if (pointsDTO.getId() != null) {
            throw new BadRequestAlertException("A new points cannot already have an ID", ENTITY_NAME, "idexists");
        }
        PointsDTO result = pointsService.save(pointsDTO);
        return ResponseEntity
            .created(new URI("/api/points/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /points/:id} : Updates an existing points.
     *
     * @param id the id of the pointsDTO to save.
     * @param pointsDTO the pointsDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated pointsDTO,
     * or with status {@code 400 (Bad Request)} if the pointsDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the pointsDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<PointsDTO> updatePoints(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody PointsDTO pointsDTO
    ) throws URISyntaxException {
        log.debug("REST request to update Points : {}, {}", id, pointsDTO);
        if (pointsDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, pointsDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!pointsRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        PointsDTO result = pointsService.update(pointsDTO);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, pointsDTO.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /points/:id} : Partial updates given fields of an existing points, field will ignore if it is null
     *
     * @param id the id of the pointsDTO to save.
     * @param pointsDTO the pointsDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated pointsDTO,
     * or with status {@code 400 (Bad Request)} if the pointsDTO is not valid,
     * or with status {@code 404 (Not Found)} if the pointsDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the pointsDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<PointsDTO> partialUpdatePoints(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody PointsDTO pointsDTO
    ) throws URISyntaxException {
        log.debug("REST request to partial update Points partially : {}, {}", id, pointsDTO);
        if (pointsDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, pointsDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!pointsRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<PointsDTO> result = pointsService.partialUpdate(pointsDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, pointsDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /points} : get all the points.
     *
     * @param filter the filter of the request.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of points in body.
     */
    @GetMapping("")
    public List<PointsDTO> getAllPoints(@RequestParam(name = "filter", required = false) String filter) {
        if ("violation-is-null".equals(filter)) {
            log.debug("REST request to get all Pointss where violation is null");
            return pointsService.findAllWhereViolationIsNull();
        }
        log.debug("REST request to get all Points");
        return pointsService.findAll();
    }

    /**
     * {@code GET  /points/:id} : get the "id" points.
     *
     * @param id the id of the pointsDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the pointsDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<PointsDTO> getPoints(@PathVariable("id") Long id) {
        log.debug("REST request to get Points : {}", id);
        Optional<PointsDTO> pointsDTO = pointsService.findOne(id);
        return ResponseUtil.wrapOrNotFound(pointsDTO);
    }

    /**
     * {@code DELETE  /points/:id} : delete the "id" points.
     *
     * @param id the id of the pointsDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePoints(@PathVariable("id") Long id) {
        log.debug("REST request to delete Points : {}", id);
        pointsService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
