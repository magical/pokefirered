#include "global.h"
#include "menu.h"
#include "list_menu.h"
#include "menu_indicators.h"
#include "new_menu_helpers.h"
#include "window.h"
#include "text_window.h"
#include "main.h"
#include "task.h"
#include "graphics.h"
#include "decompress.h"
#include "palette.h"
#include "malloc.h"
#include "strings.h"
#include "sound.h"
#include "pokemon_icon.h"
#include "constants/songs.h"

struct UnkIndicatorsStruct
{
    u8 field_0;
    u16 *field_4;
    u16 field_8;
    u16 field_A;
    u16 field_C;
    u16 field_E;
    u8 field_10;
    u8 field_11;
    u8 field_12;
    u8 field_13;
    u8 field_14_0:4;
    u8 field_14_1:4;
    u8 field_15_0:4;
    u8 field_15_1:4;
    u8 field_16_0:3;
    u8 field_16_1:3;
    u8 field_16_2:2;
    u8 field_17_0:6;
    u8 field_17_1:2;
};

struct MysteryGiftLinkMenuStruct
{
    s32 currItemId;
    u8 state;
    u8 windowId;
    u8 listTaskId;
};

struct ListMenuOverride
{
    u8 cursorPal:4;
    u8 fillValue:4;
    u8 cursorShadowPal:4;
    u8 lettersSpacing:6;
    u8 field_2_2:6; // unused
    u8 fontId:7;
    bool8 enabled:1;
};

struct MoveMenuInfoIcon
{
    u8 width;
    u8 height;
    u16 offset;
};

static EWRAM_DATA struct MysteryGiftLinkMenuStruct sMysteryGiftLinkMenu = {0};

struct ListMenuOverride gListMenuOverride;
struct ListMenuTemplate gMultiuseListMenuTemplate;

static u8 ListMenuInitInternal(struct ListMenuTemplate *listMenuTemplate, u16 scrollOffset, u16 selectedRow);
static bool8 ListMenuChangeSelection(struct ListMenu *list, bool8 updateCursorAndCallCallback, u8 count, bool8 movingDown);
static void ListMenuPrintEntries(struct ListMenu *list, u16 startIndex, u16 yOffset, u16 count);
static void ListMenuDrawCursor(struct ListMenu *list);
static void ListMenuCallSelectionChangedCallback(struct ListMenu *list, u8 onInit);
static u8 ListMenuAddCursorObject(struct ListMenu *list, u32 cursorKind);

const struct MoveMenuInfoIcon gMoveMenuInfoIcons[] =
{
    { 12, 12, 0x00 },       // Unused
    { 32, 12, 0x20 },       // Normal icon
    { 32, 12, 0x64 },       // Fight icon
    { 32, 12, 0x60 },       // Flying icon
    { 32, 12, 0x80 },       // Poison icon
    { 32, 12, 0x48 },       // Ground icon
    { 32, 12, 0x44 },       // Rock icon
    { 32, 12, 0x6C },       // Bug icon
    { 32, 12, 0x68 },       // Ghost icon
    { 32, 12, 0x88 },       // Steel icon
    { 32, 12, 0xA4 },       // ??? (Mystery) icon
    { 32, 12, 0x24 },       // Fire icon
    { 32, 12, 0x28 },       // Water icon
    { 32, 12, 0x2C },       // Grass icon
    { 32, 12, 0x40 },       // Electric icon
    { 32, 12, 0x84 },       // Psychic icon
    { 32, 12, 0x4C },       // Ice icon
    { 32, 12, 0xA0 },       // Dragon icon
    { 32, 12, 0x8C },       // Dark icon
    { 40, 12, 0xA8 },       // -Type- icon
    { 40, 12, 0xC0 },       // -Power- icon
    { 40, 12, 0xC8 },       // -Accuracy- icon
    { 40, 12, 0xE0 },       // -PP- icon
    { 40, 12, 0xE8 },       // -Effect- icon
};

static void ListMenuDummyTask(u8 taskId)
{
}

s32 DoMysteryGiftListMenu(const struct WindowTemplate *windowTemplate, const struct ListMenuTemplate *listMenuTemplate, u8 arg2, u16 tileNum, u16 palNum)
{
    switch (sMysteryGiftLinkMenu.state)
    {
    case 0:
    default:
        sMysteryGiftLinkMenu.windowId = AddWindow(windowTemplate);
        switch (arg2)
        {
        case 2:
            TextWindow_SetUserSelectedFrame(sMysteryGiftLinkMenu.windowId, tileNum, palNum);
        case 1:
            DrawTextBorderOuter(sMysteryGiftLinkMenu.windowId, tileNum, palNum / 16);
            break;
        }
        gMultiuseListMenuTemplate = *listMenuTemplate;
        gMultiuseListMenuTemplate.windowId = sMysteryGiftLinkMenu.windowId;
        sMysteryGiftLinkMenu.listTaskId = ListMenuInit(&gMultiuseListMenuTemplate, 0, 0);
        CopyWindowToVram(sMysteryGiftLinkMenu.windowId, 1);
        sMysteryGiftLinkMenu.state = 1;
        break;
    case 1:
        sMysteryGiftLinkMenu.currItemId = ListMenu_ProcessInput(sMysteryGiftLinkMenu.listTaskId);
        if (JOY_NEW(A_BUTTON))
        {
            sMysteryGiftLinkMenu.state = 2;
        }
        if (JOY_NEW(B_BUTTON))
        {
            sMysteryGiftLinkMenu.currItemId = LIST_CANCEL;
            sMysteryGiftLinkMenu.state = 2;
        }
        if (sMysteryGiftLinkMenu.state == 2)
        {
            if (!arg2)
            {
                ClearWindowTilemap(sMysteryGiftLinkMenu.windowId);
            }
            else
            {
                switch (arg2)
                {
                case 0: // can never be reached, because of the if statement above
                    ClearStdWindowAndFrame(sMysteryGiftLinkMenu.windowId, FALSE);
                    break;
                case 2:
                case 1:
                    ClearStdWindowAndFrame(sMysteryGiftLinkMenu.windowId, FALSE);
                    break;
                }
            }
            CopyWindowToVram(sMysteryGiftLinkMenu.windowId, 1);
        }
        break;
    case 2:
        DestroyListMenuTask(sMysteryGiftLinkMenu.listTaskId, NULL, NULL);
        RemoveWindow(sMysteryGiftLinkMenu.windowId);
        sMysteryGiftLinkMenu.state = 0;
        return sMysteryGiftLinkMenu.currItemId;
    }
    return LIST_NOTHING_CHOSEN;
}

u8 ListMenuInit(struct ListMenuTemplate *listMenuTemplate, u16 scrollOffset, u16 selectedRow)
{
    u8 taskId = ListMenuInitInternal(listMenuTemplate, scrollOffset, selectedRow);
    PutWindowTilemap(listMenuTemplate->windowId);
    CopyWindowToVram(listMenuTemplate->windowId, 2);
    return taskId;
}

u8 ListMenuInitInRect(struct ListMenuTemplate *listMenuTemplate, struct ListMenuWindowRect *rect, u16 scrollOffset, u16 selectedRow)
{
    s32 i;
    u8 taskId = ListMenuInitInternal(listMenuTemplate, scrollOffset, selectedRow);
    
    for (i = 0; rect[i].palNum != 0xFF; i++)
        PutWindowRectTilemapOverridePalette(listMenuTemplate->windowId, rect[i].x, rect[i].y, rect[i].width, rect[i].height, rect[i].palNum);
    CopyWindowToVram(listMenuTemplate->windowId, 2);
    return taskId;
}

s32 ListMenu_ProcessInput(u8 listTaskId)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    if (JOY_NEW(A_BUTTON))
    {
        return list->template.items[list->scrollOffset + list->selectedRow].index;
    }
    else if (JOY_NEW(B_BUTTON))
    {
        return LIST_CANCEL;
    }
    else if (gMain.newAndRepeatedKeys & DPAD_UP)
    {
        ListMenuChangeSelection(list, TRUE, 1, FALSE);
        return LIST_NOTHING_CHOSEN;
    }
    else if (gMain.newAndRepeatedKeys & DPAD_DOWN)
    {
        ListMenuChangeSelection(list, TRUE, 1, TRUE);
        return LIST_NOTHING_CHOSEN;
    }
    else // try to move by one window scroll
    {
        bool16 rightButton, leftButton;
        switch (list->template.scrollMultiple)
        {
        case LIST_NO_MULTIPLE_SCROLL:
        default:
            leftButton = FALSE;
            rightButton = FALSE;
            break;
        case LIST_MULTIPLE_SCROLL_DPAD:
            leftButton = gMain.newAndRepeatedKeys & DPAD_LEFT;
            rightButton = gMain.newAndRepeatedKeys & DPAD_RIGHT;
            break;
        case LIST_MULTIPLE_SCROLL_L_R:
            leftButton = gMain.newAndRepeatedKeys & L_BUTTON;
            rightButton = gMain.newAndRepeatedKeys & R_BUTTON;
            break;
        }
        if (leftButton)
        {
            ListMenuChangeSelection(list, TRUE, list->template.maxShowed, FALSE);
            return LIST_NOTHING_CHOSEN;
        }
        else if (rightButton)
        {
            ListMenuChangeSelection(list, TRUE, list->template.maxShowed, TRUE);
            return LIST_NOTHING_CHOSEN;
        }
        else
        {
            return LIST_NOTHING_CHOSEN;
        }
    }
}

void DestroyListMenuTask(u8 listTaskId, u16 *scrollOffset, u16 *selectedRow)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    if (scrollOffset != NULL)
        *scrollOffset = list->scrollOffset;
    if (selectedRow != NULL)
        *selectedRow = list->selectedRow;

    if (list->taskId != TASK_NONE)
        ListMenuRemoveCursorObject(list->taskId, list->template.cursorKind - 2);

    DestroyTask(listTaskId);
}

void RedrawListMenu(u8 listTaskId)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    FillWindowPixelBuffer(list->template.windowId, PIXEL_FILL(list->template.fillValue));
    ListMenuPrintEntries(list, list->scrollOffset, 0, list->template.maxShowed);
    ListMenuDrawCursor(list);
    CopyWindowToVram(list->template.windowId, 2);
}

static void ChangeListMenuPals(u8 listTaskId, u8 cursorPal, u8 fillValue, u8 cursorShadowPal)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    list->template.cursorPal = cursorPal;
    list->template.fillValue = fillValue;
    list->template.cursorShadowPal = cursorShadowPal;
}

static void ChangeListMenuCoords(u8 listTaskId, u8 x, u8 y)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    SetWindowAttribute(list->template.windowId, WINDOW_TILEMAP_LEFT, x);
    SetWindowAttribute(list->template.windowId, WINDOW_TILEMAP_TOP, y);
}

static s32 ListMenuTestInput(struct ListMenuTemplate *template, u32 scrollOffset, u32 selectedRow, u16 keys, u16 *newScrollOffset, u16 *newSelectedRow)
{
    struct ListMenu list;

    list.template = *template;
    list.scrollOffset = scrollOffset;
    list.selectedRow = selectedRow;
    list.unk_1C = 0;
    list.unk_1D = 0;
    if (keys == DPAD_UP)
        ListMenuChangeSelection(&list, FALSE, 1, FALSE);
    if (keys == DPAD_DOWN)
        ListMenuChangeSelection(&list, FALSE, 1, TRUE);

    if (newScrollOffset != NULL)
        *newScrollOffset = list.scrollOffset;
    if (newSelectedRow != NULL)
        *newSelectedRow = list.selectedRow;
    return LIST_NOTHING_CHOSEN;
}

static void ListMenuGetCurrentItemArrayId(u8 listTaskId, u16 *arrayId)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    if (arrayId != NULL)
        *arrayId = list->scrollOffset + list->selectedRow;
}

void ListMenuGetScrollAndRow(u8 listTaskId, u16 *scrollOffset, u16 *selectedRow)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    if (scrollOffset != NULL)
        *scrollOffset = list->scrollOffset;
    if (selectedRow != NULL)
        *selectedRow = list->selectedRow;
}

u16 ListMenuGetYCoordForPrintingArrowCursor(u8 listTaskId)
{
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;
    u8 yMultiplier = GetFontAttribute(list->template.fontId, FONTATTR_MAX_LETTER_HEIGHT) + list->template.itemVerticalPadding;

    return list->selectedRow * yMultiplier + list->template.upText_Y;
}

static u8 ListMenuInitInternal(struct ListMenuTemplate *listMenuTemplate, u16 scrollOffset, u16 selectedRow)
{
    u8 listTaskId = CreateTask(ListMenuDummyTask, 0);
    struct ListMenu *list = (struct ListMenu *)gTasks[listTaskId].data;

    list->template = *listMenuTemplate;
    list->scrollOffset = scrollOffset;
    list->selectedRow = selectedRow;
    list->unk_1C = 0;
    list->unk_1D = 0;
    list->taskId = TASK_NONE;
    list->unk_1F = 0;
    gListMenuOverride.cursorPal = list->template.cursorPal;
    gListMenuOverride.fillValue = list->template.fillValue;
    gListMenuOverride.cursorShadowPal = list->template.cursorShadowPal;
    gListMenuOverride.lettersSpacing = list->template.lettersSpacing;
    gListMenuOverride.fontId = list->template.fontId;
    gListMenuOverride.enabled = FALSE;
    if (list->template.totalItems < list->template.maxShowed)
        list->template.maxShowed = list->template.totalItems;
    FillWindowPixelBuffer(list->template.windowId, PIXEL_FILL(list->template.fillValue));
    ListMenuPrintEntries(list, list->scrollOffset, 0, list->template.maxShowed);
    ListMenuDrawCursor(list);
    ListMenuCallSelectionChangedCallback(list, TRUE);

    return listTaskId;
}

static void ListMenuPrint(struct ListMenu *list, const u8 *str, u8 x, u8 y)
{
    struct TextColor colors;
    if (gListMenuOverride.enabled)
    {
        colors.fgColor = gListMenuOverride.fillValue;
        colors.bgColor = gListMenuOverride.cursorPal;
        colors.shadowColor = gListMenuOverride.cursorShadowPal;
        AddTextPrinterParameterized4(list->template.windowId, gListMenuOverride.fontId, x, y, gListMenuOverride.lettersSpacing, 0, &colors, TEXT_SPEED_FF, str);
        gListMenuOverride.enabled = FALSE;
    }
    else
    {
        colors.fgColor = list->template.fillValue;
        colors.bgColor = list->template.cursorPal;
        colors.shadowColor = list->template.cursorShadowPal;
        AddTextPrinterParameterized4(list->template.windowId, list->template.fontId, x, y, list->template.lettersSpacing, 0, &colors, TEXT_SPEED_FF, str);
    }
}

static void ListMenuPrintEntries(struct ListMenu *list, u16 startIndex, u16 yOffset, u16 count)
{
    s32 i;
    u8 x, y;
    u8 yMultiplier = GetFontAttribute(list->template.fontId, FONTATTR_MAX_LETTER_HEIGHT) + list->template.itemVerticalPadding;

    for (i = 0; i < count; i++)
    {
        if (list->template.items[startIndex].index != LIST_HEADER)
            x = list->template.item_X;
        else
            x = list->template.header_X;
        y = (yOffset + i) * yMultiplier + list->template.upText_Y;
        if (list->template.itemPrintFunc != NULL)
            list->template.itemPrintFunc(list->template.windowId, list->template.items[startIndex].index, y);
        ListMenuPrint(list, list->template.items[startIndex].label, x, y);
        startIndex++;
    }
}

static void ListMenuDrawCursor(struct ListMenu *list)
{
    u8 yMultiplier = GetFontAttribute(list->template.fontId, FONTATTR_MAX_LETTER_HEIGHT) + list->template.itemVerticalPadding;
    u8 x = list->template.cursor_X;
    u8 y = list->selectedRow * yMultiplier + list->template.upText_Y;
    
    switch (list->template.cursorKind)
    {
    case 0:
        ListMenuPrint(list, gFameCheckerText_ListMenuCursor, x, y);
        break;
    case 1:
        break;
    case 2:
        if (list->taskId == TASK_NONE)
            list->taskId = ListMenuAddCursorObject(list, 0);
        ListMenuUpdateCursorObject(list->taskId, GetWindowAttribute(list->template.windowId, WINDOW_TILEMAP_LEFT) * 8 - 1, GetWindowAttribute(list->template.windowId, WINDOW_TILEMAP_TOP) * 8 + y - 1, 0);
        break;
    case 3:
        if (list->taskId == TASK_NONE)
            list->taskId = ListMenuAddCursorObject(list, 1);
        ListMenuUpdateCursorObject(list->taskId, GetWindowAttribute(list->template.windowId, WINDOW_TILEMAP_LEFT) * 8 + x, GetWindowAttribute(list->template.windowId, WINDOW_TILEMAP_TOP) * 8 + y, 1);
        break;
    }
}

static u8 ListMenuAddCursorObject(struct ListMenu *list, u32 cursorKind)
{
    struct CursorStruct cursor;

    cursor.left = 0;
    cursor.top = 160;
    cursor.rowWidth = GetWindowAttribute(list->template.windowId, WINDOW_WIDTH) * 8 + 2;
    cursor.rowHeight = GetFontAttribute(list->template.fontId, FONTATTR_MAX_LETTER_HEIGHT) + 2;
    cursor.tileTag = 0x4000;
    cursor.palTag = SPRITE_INVALID_TAG;
    cursor.palNum = 15;
    return ListMenuAddCursorObjectInternal(&cursor, cursorKind);
}

static void ListMenuErasePrintedCursor(struct ListMenu *list, u16 selectedRow)
{
    u8 cursorKind = list->template.cursorKind;
    if (cursorKind == 0)
    {
        u8 yMultiplier = GetFontAttribute(list->template.fontId, FONTATTR_MAX_LETTER_HEIGHT) + list->template.itemVerticalPadding;
        u8 width  = GetMenuCursorDimensionByFont(list->template.fontId, 0);
        u8 height = GetMenuCursorDimensionByFont(list->template.fontId, 1);
        FillWindowPixelRect(list->template.windowId,
                            PIXEL_FILL(list->template.fillValue),
                            list->template.cursor_X,
                            selectedRow * yMultiplier + list->template.upText_Y,
                            width,
                            height);
    }
}

static u8 ListMenuUpdateSelectedRowIndexAndScrollOffset(struct ListMenu *list, bool8 movingDown)
{
    u16 selectedRow = list->selectedRow;
    u16 scrollOffset = list->scrollOffset;
    u16 newRow;
    u32 newScroll;

    if (!movingDown)
    {
        if (list->template.maxShowed == 1)
            newRow = 0;
        else
            newRow = list->template.maxShowed - ((list->template.maxShowed / 2) + (list->template.maxShowed % 2)) - 1;

        if (scrollOffset == 0)
        {
            while (selectedRow != 0)
            {
                selectedRow--;
                if (list->template.items[scrollOffset + selectedRow].index != LIST_HEADER)
                {
                    list->selectedRow = selectedRow;
                    return 1;
                }
            }
            return 0;
        }
        else
        {
            while (selectedRow > newRow)
            {
                selectedRow--;
                if (list->template.items[scrollOffset + selectedRow].index != LIST_HEADER)
                {
                    list->selectedRow = selectedRow;
                    return 1;
                }
            }
            newScroll = scrollOffset - 1;
        }
    }
    else
    {
        if (list->template.maxShowed == 1)
            newRow = 0;
        else
            newRow = ((list->template.maxShowed / 2) + (list->template.maxShowed % 2));

        if (scrollOffset == list->template.totalItems - list->template.maxShowed)
        {
            while (selectedRow < list->template.maxShowed - 1)
            {
                selectedRow++;
                if (list->template.items[scrollOffset + selectedRow].index != LIST_HEADER)
                {
                    list->selectedRow = selectedRow;
                    return 1;
                }
            }
            return 0;
        }
        else
        {
            while (selectedRow < newRow)
            {
                selectedRow++;
                if (list->template.items[scrollOffset + selectedRow].index != LIST_HEADER)
                {
                    list->selectedRow = selectedRow;
                    return 1;
                }
            }
            newScroll = scrollOffset + 1;
        }
    }
    list->selectedRow = newRow;
    list->scrollOffset = newScroll;
    return 2;
}

static void ListMenuScroll(struct ListMenu *list, u8 count, bool8 movingDown)
{
    if (count >= list->template.maxShowed)
    {
        FillWindowPixelBuffer(list->template.windowId, PIXEL_FILL(list->template.fillValue));
        ListMenuPrintEntries(list, list->scrollOffset, 0, list->template.maxShowed);
    }
    else
    {
        u8 yMultiplier = GetFontAttribute(list->template.fontId, FONTATTR_MAX_LETTER_HEIGHT) + list->template.itemVerticalPadding;

        if (!movingDown)
        {
            u16 y, width, height;

            ScrollWindow(list->template.windowId, 1, count * yMultiplier, PIXEL_FILL(list->template.fillValue));
            ListMenuPrintEntries(list, list->scrollOffset, 0, count);

            y = (list->template.maxShowed * yMultiplier) + list->template.upText_Y;
            width = GetWindowAttribute(list->template.windowId, WINDOW_WIDTH) * 8;
            height = (GetWindowAttribute(list->template.windowId, WINDOW_HEIGHT) * 8) - y;
            FillWindowPixelRect(list->template.windowId,
                                PIXEL_FILL(list->template.fillValue),
                                0, y, width, height);
        }
        else
        {
            u16 width;

            ScrollWindow(list->template.windowId, 0, count * yMultiplier, PIXEL_FILL(list->template.fillValue));
            ListMenuPrintEntries(list, list->scrollOffset + (list->template.maxShowed - count), list->template.maxShowed - count, count);

            width = GetWindowAttribute(list->template.windowId, WINDOW_WIDTH) * 8;
            FillWindowPixelRect(list->template.windowId,
                                PIXEL_FILL(list->template.fillValue),
                                0, 0, width, list->template.upText_Y);
        }
    }
}

static bool8 ListMenuChangeSelection(struct ListMenu *list, bool8 updateCursorAndCallCallback, u8 count, bool8 movingDown)
{
    u16 oldSelectedRow;
    u8 selectionChange, i, cursorCount;

    oldSelectedRow = list->selectedRow;
    cursorCount = 0;
    selectionChange = 0;
    for (i = 0; i < count; i++)
    {
        do
        {
            u8 ret = ListMenuUpdateSelectedRowIndexAndScrollOffset(list, movingDown);
            
            selectionChange |= ret;
            if (ret != 2)
                break;
            cursorCount++;
        }
        while (list->template.items[list->scrollOffset + list->selectedRow].index == LIST_HEADER);
    }

    if (updateCursorAndCallCallback)
    {
        switch (selectionChange)
        {
        case 0:
        default:
            return TRUE;
        case 1:
            ListMenuErasePrintedCursor(list, oldSelectedRow);
            ListMenuDrawCursor(list);
            ListMenuCallSelectionChangedCallback(list, FALSE);
            CopyWindowToVram(list->template.windowId, 2);
            break;
        case 2:
        case 3:
            ListMenuErasePrintedCursor(list, oldSelectedRow);
            ListMenuScroll(list, cursorCount, movingDown);
            ListMenuDrawCursor(list);
            ListMenuCallSelectionChangedCallback(list, FALSE);
            CopyWindowToVram(list->template.windowId, 2);
            break;
        }
    }
    return FALSE;
}

static void ListMenuCallSelectionChangedCallback(struct ListMenu *list, u8 onInit)
{
    if (list->template.moveCursorFunc != NULL)
        list->template.moveCursorFunc(list->template.items[list->scrollOffset + list->selectedRow].index, onInit, list);
}

void ListMenuOverrideSetColors(u8 cursorPal, u8 fillValue, u8 cursorShadowPal)
{
    gListMenuOverride.cursorPal = cursorPal;
    gListMenuOverride.fillValue = fillValue;
    gListMenuOverride.cursorShadowPal = cursorShadowPal;
    gListMenuOverride.enabled = TRUE;
}

void ListMenuDefaultCursorMoveFunc(s32 itemIndex, bool8 onInit, struct ListMenu *list)
{
    if (!onInit)
        PlaySE(SE_SELECT);
}

static s32 ListMenuGetUnkIndicatorsStructFields(u8 taskId, u8 field)
{
    struct UnkIndicatorsStruct *data = (struct UnkIndicatorsStruct *)gTasks[taskId].data;

    switch (field)
    {
    case 0:
    case 1:
        return (s32)(data->field_4);
    case 2:
        return data->field_C;
    case 3:
        return data->field_E;
    case 4:
        return data->field_10;
    case 5:
        return data->field_11;
    case 6:
        return data->field_12;
    case 7:
        return data->field_13;
    case 8:
        return data->field_14_0;
    case 9:
        return data->field_14_1;
    case 10:
        return data->field_15_0;
    case 11:
        return data->field_15_1;
    case 12:
        return data->field_16_0;
    case 13:
        return data->field_16_1;
    case 14:
        return data->field_16_2;
    case 15:
        return data->field_17_0;
    case 16:
        return data->field_17_1;
    default:
        return -1;
    }
}

void ListMenuSetUnkIndicatorsStructField(u8 taskId, u8 field, s32 value)
{
    struct UnkIndicatorsStruct *data = (struct UnkIndicatorsStruct *)gTasks[taskId].data;

    switch (field)
    {
    case 0:
    case 1:
        data->field_4 = (void *)value;
        break;
    case 2:
        data->field_C = value;
        break;
    case 3:
        data->field_E = value;
        break;
    case 4:
        data->field_10 = value;
        break;
    case 5:
        data->field_11 = value;
        break;
    case 6:
        data->field_12 = value;
        break;
    case 7:
        data->field_13 = value;
        break;
    case 8:
        data->field_14_0 = value;
        break;
    case 9:
        data->field_14_1 = value;
        break;
    case 10:
        data->field_15_0 = value;
        break;
    case 11:
        data->field_15_1 = value;
        break;
    case 12:
        data->field_16_0 = value;
        break;
    case 13:
        data->field_16_1 = value;
        break;
    case 14:
        data->field_16_2 = value;
        break;
    case 15:
        data->field_17_0 = value;
        break;
    case 16:
        data->field_17_1 = value;
        break;
    }
}

void sub_8107CD8(u8 palOffset, u16 speciesId)
{
    LoadPalette(GetValidMonIconPalettePtr(speciesId), palOffset, 0x20);
}

void sub_8107CF8(u8 windowId, u16 speciesId, u32 personality, u16 x, u16 y)
{
    BlitBitmapToWindow(windowId, GetMonIconPtr(speciesId, personality, 1), x, y, 32, 32);
}

void sub_8107D38(u8 palOffset, u8 palId)
{
    const u16 *palette;

    switch (palId)
    {
    case 0:
    default:
        palette = gFireRedMenuElements1_Pal;
        break;
    case 1:
        palette = gFireRedMenuElements2_Pal;
        break;
    }
    LoadPalette(palette, palOffset, 0x20);
}

void BlitMoveInfoIcon(u8 windowId, u8 iconId, u16 x, u16 y)
{
    BlitBitmapRectToWindow(windowId, gFireRedMenuElements_Gfx + gMoveMenuInfoIcons[iconId].offset * 32, 0, 0, 128, 128, x, y, gMoveMenuInfoIcons[iconId].width, gMoveMenuInfoIcons[iconId].height);
}
