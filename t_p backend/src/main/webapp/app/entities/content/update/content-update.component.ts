import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IAppUser } from 'app/entities/app-user/app-user.model';
import { AppUserService } from 'app/entities/app-user/service/app-user.service';
import { IContent } from '../content.model';
import { ContentService } from '../service/content.service';
import { ContentFormService, ContentFormGroup } from './content-form.service';

@Component({
  standalone: true,
  selector: 'jhi-content-update',
  templateUrl: './content-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class ContentUpdateComponent implements OnInit {
  isSaving = false;
  content: IContent | null = null;

  appUsersSharedCollection: IAppUser[] = [];

  editForm: ContentFormGroup = this.contentFormService.createContentFormGroup();

  constructor(
    protected contentService: ContentService,
    protected contentFormService: ContentFormService,
    protected appUserService: AppUserService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  compareAppUser = (o1: IAppUser | null, o2: IAppUser | null): boolean => this.appUserService.compareAppUser(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ content }) => {
      this.content = content;
      if (content) {
        this.updateForm(content);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const content = this.contentFormService.getContent(this.editForm);
    if (content.id !== null) {
      this.subscribeToSaveResponse(this.contentService.update(content));
    } else {
      this.subscribeToSaveResponse(this.contentService.create(content));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IContent>>): void {
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

  protected updateForm(content: IContent): void {
    this.content = content;
    this.contentFormService.resetForm(this.editForm, content);

    this.appUsersSharedCollection = this.appUserService.addAppUserToCollectionIfMissing<IAppUser>(
      this.appUsersSharedCollection,
      content.appUser,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.appUserService
      .query()
      .pipe(map((res: HttpResponse<IAppUser[]>) => res.body ?? []))
      .pipe(map((appUsers: IAppUser[]) => this.appUserService.addAppUserToCollectionIfMissing<IAppUser>(appUsers, this.content?.appUser)))
      .subscribe((appUsers: IAppUser[]) => (this.appUsersSharedCollection = appUsers));
  }
}
