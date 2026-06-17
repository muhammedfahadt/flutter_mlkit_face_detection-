import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IPoints } from 'app/entities/points/points.model';
import { PointsService } from 'app/entities/points/service/points.service';
import { IAppUser } from 'app/entities/app-user/app-user.model';
import { AppUserService } from 'app/entities/app-user/service/app-user.service';
import { IContent } from 'app/entities/content/content.model';
import { ContentService } from 'app/entities/content/service/content.service';
import { ViolationService } from '../service/violation.service';
import { IViolation } from '../violation.model';
import { ViolationFormService, ViolationFormGroup } from './violation-form.service';

@Component({
  standalone: true,
  selector: 'jhi-violation-update',
  templateUrl: './violation-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class ViolationUpdateComponent implements OnInit {
  isSaving = false;
  violation: IViolation | null = null;

  pointsCollection: IPoints[] = [];
  appUsersSharedCollection: IAppUser[] = [];
  contentsSharedCollection: IContent[] = [];

  editForm: ViolationFormGroup = this.violationFormService.createViolationFormGroup();

  constructor(
    protected violationService: ViolationService,
    protected violationFormService: ViolationFormService,
    protected pointsService: PointsService,
    protected appUserService: AppUserService,
    protected contentService: ContentService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  comparePoints = (o1: IPoints | null, o2: IPoints | null): boolean => this.pointsService.comparePoints(o1, o2);

  compareAppUser = (o1: IAppUser | null, o2: IAppUser | null): boolean => this.appUserService.compareAppUser(o1, o2);

  compareContent = (o1: IContent | null, o2: IContent | null): boolean => this.contentService.compareContent(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ violation }) => {
      this.violation = violation;
      if (violation) {
        this.updateForm(violation);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const violation = this.violationFormService.getViolation(this.editForm);
    if (violation.id !== null) {
      this.subscribeToSaveResponse(this.violationService.update(violation));
    } else {
      this.subscribeToSaveResponse(this.violationService.create(violation));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IViolation>>): void {
    result.pipe(finalize(() => this.onSaveFinalize())).subscribe({
      next: () => this.onSaveSuccess(),
      error: () => this.onSaveError(),
    });
  }

  protected onSaveSuccess(): void {
    this.previousState();
  }

  protected onSaveError(): void {
    // Api for inheritance.
  }

  protected onSaveFinalize(): void {
    this.isSaving = false;
  }

  protected updateForm(violation: IViolation): void {
    this.violation = violation;
    this.violationFormService.resetForm(this.editForm, violation);

    this.pointsCollection = this.pointsService.addPointsToCollectionIfMissing<IPoints>(this.pointsCollection, violation.points);
    this.appUsersSharedCollection = this.appUserService.addAppUserToCollectionIfMissing<IAppUser>(
      this.appUsersSharedCollection,
      violation.appUser,
    );
    this.contentsSharedCollection = this.contentService.addContentToCollectionIfMissing<IContent>(
      this.contentsSharedCollection,
      violation.content,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.pointsService
      .query({ filter: 'violation-is-null' })
      .pipe(map((res: HttpResponse<IPoints[]>) => res.body ?? []))
      .pipe(map((points: IPoints[]) => this.pointsService.addPointsToCollectionIfMissing<IPoints>(points, this.violation?.points)))
      .subscribe((points: IPoints[]) => (this.pointsCollection = points));

    this.appUserService
      .query()
      .pipe(map((res: HttpResponse<IAppUser[]>) => res.body ?? []))
      .pipe(map((appUsers: IAppUser[]) => this.appUserService.addAppUserToCollectionIfMissing<IAppUser>(appUsers, this.violation?.appUser)))
      .subscribe((appUsers: IAppUser[]) => (this.appUsersSharedCollection = appUsers));

    this.contentService
      .query()
      .pipe(map((res: HttpResponse<IContent[]>) => res.body ?? []))
      .pipe(map((contents: IContent[]) => this.contentService.addContentToCollectionIfMissing<IContent>(contents, this.violation?.content)))
      .subscribe((contents: IContent[]) => (this.contentsSharedCollection = contents));
  }
}
