import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IContent } from '../content.model';
import { ContentService } from '../service/content.service';

@Component({
  standalone: true,
  templateUrl: './content-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class ContentDeleteDialogComponent {
  content?: IContent;

  constructor(
    protected contentService: ContentService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.contentService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
