$('#editScheduleModal').on('show.bs.modal', function (e) {
    const button = e.relatedTarget; // Button that triggered the modal
    const schdId = button.getAttribute('data-schdid');

    const modal = $(this);
    modal.attr('data-schdid', schdId);

    const sessionTable = modal.find('tbody');
    
    const dayMap = {
        0: "Sunday",
        1: "Monday",
        2: "Tuesday",
        3: "Wednesday",
        4: "Thursday",
        5: "Friday",
        6: "Saturday"
    };

    const filteredSessions = allSessions.filter(s => s.SchdId === parseInt(schdId));
    sessionTable.empty();

    filteredSessions.forEach((session, index) => {
        const dayName = dayMap[session.TslDay] ?? "Invalid Day";

        const row = `
        <tr data-ssnid="${session.SsnId}">
            <td>${index + 1}</td>
            <td>${dayName}</td>
            <td>${session.TslStartTime}</td>
            <td>${session.TslEndTime}</td>
            <td>
                <button class="btn btn-sm btn-warning edit-session-btn" data-bs-toggle="modal" data-bs-target="#editSessionModal" data-parent="#editScheduleModal" data-ssnid="${session.SsnId}">Edit</button>
            </td>
        </tr>`;
        sessionTable.append(row);
    });
});

let currentSchdId = null;

// When clicking the Edit Schedule button
document.querySelectorAll('.edit-sched-btn').forEach(btn => {
    btn.addEventListener('click', e => {
        currentSchdId = btn.getAttribute('data-schdid');
    });
});

const addSessionModal = document.getElementById('addSessionModal');
addSessionModal.addEventListener('show.bs.modal', () => {
    const input = addSessionModal.querySelector('input[name="SchdId"]');
    if (input && currentSchdId) {
        input.value = currentSchdId;
    }
});

$(function() {
    const dayMap = {
        0: "Sunday",
        1: "Monday",
        2: "Tuesday",
        3: "Wednesday",
        4: "Thursday",
        5: "Friday",
        6: "Saturday"
    };
    // Reverse lookup for the select
    const reverseDayMap = Object.fromEntries(
        Object.entries(dayMap).map(([k, v]) => [v, k])
    );

    // Delegate to catch dynamically added buttons
    $(document).on('click', '.edit-session-btn', function() {
        const ssnId = $(this).data('ssnid');
        const session = allSessions.find(s => s.SsnId === ssnId);
        if (!session) return console.error("Session not found", ssnId);

        // Prefill inputs in the Edit Session modal
        const $modal = $('#editSessionModal');
        $modal.find('input[name="SsnId"]').val(session.SsnId);
        $modal.find('input[name="SchdId"]').val(session.SchdId);
        $modal.find('select[name="TslDay"]').val(session.TslDay);
        // Ensure time strings are correctly formatted "HH:MM"
        $modal.find('input[name="TslStartTime"]').val(session.TslStartTime);
        $modal.find('input[name="TslEndTime"]').val(session.TslEndTime);
    });
});

