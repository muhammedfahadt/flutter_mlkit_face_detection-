package com.divisosoft.trafficpatrol.web.rest;

import com.divisosoft.trafficpatrol.repository.ContentBlobRepository;
import com.divisosoft.trafficpatrol.service.ContentBlobService;
import com.divisosoft.trafficpatrol.service.dto.ContentBlobDTO;
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
 * REST controller for managing {@link com.divisosoft.trafficpatrol.domain.ContentBlob}.
 */
@RestController
@RequestMapping("/api/content-blobs")
public class ContentBlobResource {

    private final Logger log = LoggerFactory.getLogger(ContentBlobResource.class);

    private static final String ENTITY_NAME = "contentBlob";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final ContentBlobService contentBlobService;

    private final ContentBlobRepository contentBlobRepository;

    public ContentBlobResource(ContentBlobService contentBlobService, ContentBlobRepository contentBlobRepository) {
        this.contentBlobService = contentBlobService;
        this.contentBlobRepository = contentBlobRepository;
    }

    /**
     * {@code POST  /content-blobs} : Create a new contentBlob.
     *
     * @param contentBlobDTO the contentBlobDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new contentBlobDTO, or with status {@code 400 (Bad Request)} if the contentBlob has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<ContentBlobDTO> createContentBlob(@RequestBody ContentBlobDTO contentBlobDTO) throws URISyntaxException {
        log.debug("REST request to save ContentBlob : {}", contentBlobDTO);
        if (contentBlobDTO.getId() != null) {
            throw new BadRequestAlertException("A new contentBlob cannot already have an ID", ENTITY_NAME, "idexists");
        }
        ContentBlobDTO result = contentBlobService.save(contentBlobDTO);
        return ResponseEntity
            .created(new URI("/api/content-blobs/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /content-blobs/:id} : Updates an existing contentBlob.
     *
     * @param id the id of the contentBlobDTO to save.
     * @param contentBlobDTO the contentBlobDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated contentBlobDTO,
     * or with status {@code 400 (Bad Request)} if the contentBlobDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the contentBlobDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<ContentBlobDTO> updateContentBlob(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody ContentBlobDTO contentBlobDTO
    ) throws URISyntaxException {
        log.debug("REST request to update ContentBlob : {}, {}", id, contentBlobDTO);
        if (contentBlobDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, contentBlobDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!contentBlobRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        ContentBlobDTO result = contentBlobService.update(contentBlobDTO);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, contentBlobDTO.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /content-blobs/:id} : Partial updates given fields of an existing contentBlob, field will ignore if it is null
     *
     * @param id the id of the contentBlobDTO to save.
     * @param contentBlobDTO the contentBlobDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated contentBlobDTO,
     * or with status {@code 400 (Bad Request)} if the contentBlobDTO is not valid,
     * or with status {@code 404 (Not Found)} if the contentBlobDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the contentBlobDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<ContentBlobDTO> partialUpdateContentBlob(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody ContentBlobDTO contentBlobDTO
    ) throws URISyntaxException {
        log.debug("REST request to partial update ContentBlob partially : {}, {}", id, contentBlobDTO);
        if (contentBlobDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, contentBlobDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!contentBlobRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<ContentBlobDTO> result = contentBlobService.partialUpdate(contentBlobDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, contentBlobDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /content-blobs} : get all the contentBlobs.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of contentBlobs in body.
     */
    @GetMapping("")
    public List<ContentBlobDTO> getAllContentBlobs() {
        log.debug("REST request to get all ContentBlobs");
        return contentBlobService.findAll();
    }

    /**
     * {@code GET  /content-blobs/:id} : get the "id" contentBlob.
     *
     * @param id the id of the contentBlobDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the contentBlobDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<ContentBlobDTO> getContentBlob(@PathVariable("id") Long id) {
        log.debug("REST request to get ContentBlob : {}", id);
        Optional<ContentBlobDTO> contentBlobDTO = contentBlobService.findOne(id);
        return ResponseUtil.wrapOrNotFound(contentBlobDTO);
    }

    /**
     * {@code DELETE  /content-blobs/:id} : delete the "id" contentBlob.
     *
     * @param id the id of the contentBlobDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteContentBlob(@PathVariable("id") Long id) {
        log.debug("REST request to delete ContentBlob : {}", id);
        contentBlobService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
