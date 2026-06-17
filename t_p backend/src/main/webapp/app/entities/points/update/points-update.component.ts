import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IAppUser } from 'app/entities/app-user/app-user.model';
import { AppUserService } from 'app/entities/app-user/service/app-user.service';
import { IPoints } from '../points.model';
import { PointsService } from '../service/points.service';
import { PointsFormService, PointsFormGroup } from './points-form.service';

@Component({
  standalone: true,
  selector: 'jhi-points-update',
  templateUrl: './points-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class PointsUpdateComponent implements OnInit {
  isSaving = false;
  points: IPoints | null = null;

  appUsersSharedCollection: IAppUser[] = [];

  editForm: PointsFormGroup = this.pointsFormService.createPointsFormGroup();

  constructor(
    protected pointsService: PointsService,
    protected pointsFormService: PointsFormService,
    protected appUserService: AppUserService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  compareAppUser = (o1: IAppUser | null, o2: IAppUser | null): boolean => this.appUserService.compareAppUser(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ points }) => {
      this.points = points;
      if (points) {
        this.updateForm(points);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const points = this.pointsFormService.getPoints(this.editForm);
    if (points.id !== null) {
      this.subscribeToSaveResponse(this.pointsService.update(points));
    } else {
      this.subscribeToSaveResponse(this.pointsService.create(points));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IPoints>>): void {
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

  protected updateForm(points: IPoints): void {
    this.points = points;
    this.pointsFormService.resetForm(this.editForm, points);

    this.appUsersSharedCollection = this.appUserService.addAppUserToCollectionIfMissing<IAppUser>(
      this.appUsersSharedCollection,
      points.appUser,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.appUserService
      .query()
      .pipe(map((res: HttpResponse<IAppUser[]>) => res.body ?? []))
      .pipe(map((appUsers: IAppUser[]) => this.appUserService.addAppUserToCollectionIfMissing<IAppUser>(appUsers, this.points?.appUser)))
      .subscribe((appUsers: IAppUser[]) => (this.appUsersSharedCollection = appUsers));
  }
}
