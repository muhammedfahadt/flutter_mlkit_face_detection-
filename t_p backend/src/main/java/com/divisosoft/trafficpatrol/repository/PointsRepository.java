package com.divisosoft.trafficpatrol.repository;

import com.divisosoft.trafficpatrol.domain.Points;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the Points entity.
 */
@SuppressWarnings("unused")
@Repository
public interface PointsRepository extends JpaRepository<Points, Long> {}
