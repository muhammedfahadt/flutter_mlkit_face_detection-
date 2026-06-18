package com.divisosoft.trafficpatrol.service.impl;

import com.divisosoft.trafficpatrol.domain.Points;
import com.divisosoft.trafficpatrol.repository.PointsRepository;
import com.divisosoft.trafficpatrol.service.PointsService;
import com.divisosoft.trafficpatrol.service.dto.PointsDTO;
import com.divisosoft.trafficpatrol.service.mapper.PointsMapper;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.divisosoft.trafficpatrol.domain.Points}.
 */
@Service
@Transactional
public class PointsServiceImpl implements PointsService {

    private final Logger log = LoggerFactory.getLogger(PointsServiceImpl.class);

    private final PointsRepository pointsRepository;

    private final PointsMapper pointsMapper;

    public PointsServiceImpl(PointsRepository pointsRepository, PointsMapper pointsMapper) {
        this.pointsRepository = pointsRepository;
        this.pointsMapper = pointsMapper;
    }

    @Override
    public PointsDTO save(PointsDTO pointsDTO) {
        log.debug("Request to save Points : {}", pointsDTO);
        Points points = pointsMapper.toEntity(pointsDTO);
        points = pointsRepository.save(points);
        return pointsMapper.toDto(points);
    }

    @Override
    public PointsDTO update(PointsDTO pointsDTO) {
        log.debug("Request to update Points : {}", pointsDTO);
        Points points = pointsMapper.toEntity(pointsDTO);
        points = pointsRepository.save(points);
        return pointsMapper.toDto(points);
    }

    @Override
    public Optional<PointsDTO> partialUpdate(PointsDTO pointsDTO) {
        log.debug("Request to partially update Points : {}", pointsDTO);

        return pointsRepository
            .findById(pointsDTO.getId())
            .map(existingPoints -> {
                pointsMapper.partialUpdate(existingPoints, pointsDTO);

                return existingPoints;
            })
            .map(pointsRepository::save)
            .map(pointsMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public List<PointsDTO> findAll() {
        log.debug("Request to get all Points");
        return pointsRepository.findAll().stream().map(pointsMapper::toDto).collect(Collectors.toCollection(LinkedList::new));
    }

    /**
     *  Get all the points where Violation is {@code null}.
     *  @return the list of entities.
     */
    @Transactional(readOnly = true)
    public List<PointsDTO> findAllWhereViolationIsNull() {
        log.debug("Request to get all points where Violation is null");
        return StreamSupport
            .stream(pointsRepository.findAll().spliterator(), false)
            .filter(points -> points.getViolation() == null)
            .map(pointsMapper::toDto)
            .collect(Collectors.toCollection(LinkedList::new));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<PointsDTO> findOne(Long id) {
        log.debug("Request to get Points : {}", id);
        return pointsRepository.findById(id).map(pointsMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        log.debug("Request to delete Points : {}", id);
        pointsRepository.deleteById(id);
    }
}
