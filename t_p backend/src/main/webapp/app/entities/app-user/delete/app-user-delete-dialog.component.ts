import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IAppUser } from '../app-user.model';
import { AppUserService } from '../service/app-user.service';

@Component({
  standalone: true,
  templateUrl: './app-user-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class AppUserDeleteDialogComponent {
  appUser?: IAppUser;

  constructor(
    protected appUserService: AppUserService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.appUserService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
