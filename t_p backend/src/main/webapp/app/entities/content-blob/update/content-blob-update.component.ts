import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AlertError } from 'app/shared/alert/alert-error.model';
import { EventManager, EventWithContent } from 'app/core/util/event-manager.service';
import { DataUtils, FileLoadError } from 'app/core/util/data-util.service';
import { IContent } from 'app/entities/content/content.model';
import { ContentService } from 'app/entities/content/service/content.service';
import { ContentBlobService } from '../service/content-blob.service';
import { IContentBlob } from '../content-blob.model';
import { ContentBlobFormService, ContentBlobFormGroup } from './content-blob-form.service';

@Component({
  standalone: true,
  selector: 'jhi-content-blob-update',
  templateUrl: './content-blob-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class ContentBlobUpdateComponent implements OnInit {
  isSaving = false;
  contentBlob: IContentBlob | null = null;

  contentsSharedCollection: IContent[] = [];

  editForm: ContentBlobFormGroup = this.contentBlobFormService.createContentBlobFormGroup();

  constructor(
    protected dataUtils: DataUtils,
    protected eventManager: EventManager,
    protected contentBlobService: ContentBlobService,
    protected contentBlobFormService: ContentBlobFormService,
    protected contentService: ContentService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  compareContent = (o1: IContent | null, o2: IContent | null): boolean => this.contentService.compareContent(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ contentBlob }) => {
      this.contentBlob = contentBlob;
      if (contentBlob) {
        this.updateForm(contentBlob);
      }

      this.loadRelationshipsOptions();
    });
  }

  byteSize(base64String: string): string {
    return this.dataUtils.byteSize(base64String);
  }

  openFile(base64String: string, contentType: string | null | undefined): void {
    this.dataUtils.openFile(base64String, contentType);
  }

  setFileData(event: Event, field: string, isImage: boolean): void {
    this.dataUtils.loadFileToForm(event, this.editForm, field, isImage).subscribe({
      error: (err: FileLoadError) =>
        this.eventManager.broadcast(new EventWithContent<AlertError>('trafficpatrolApp.error', { ...err, key: 'error.file.' + err.key })),
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const contentBlob = this.contentBlobFormService.getContentBlob(this.editForm);
    if (contentBlob.id !== null) {
      this.subscribeToSaveResponse(this.contentBlobService.update(contentBlob));
    } else {
      this.subscribeToSaveResponse(this.contentBlobService.create(contentBlob));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IContentBlob>>): void {
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

  protected updateForm(contentBlob: IContentBlob): void {
    this.contentBlob = contentBlob;
    this.contentBlobFormService.resetForm(this.editForm, contentBlob);

    this.contentsSharedCollection = this.contentService.addContentToCollectionIfMissing<IContent>(
      this.contentsSharedCollection,
      contentBlob.content,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.contentService
      .query()
      .pipe(map((res: HttpResponse<IContent[]>) => res.body ?? []))
      .pipe(
        map((contents: IContent[]) => this.contentService.addContentToCollectionIfMissing<IContent>(contents, this.contentBlob?.content)),
      )
      .subscribe((contents: IContent[]) => (this.contentsSharedCollection = contents));
  }
}
