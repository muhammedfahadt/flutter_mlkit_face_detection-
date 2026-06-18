package com.divisosoft.trafficpatrol.repository;

import com.divisosoft.trafficpatrol.domain.ContentBlob;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the ContentBlob entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ContentBlobRepository extends JpaRepository<ContentBlob, Long> {}
